class SeleniumCodeBuilder

  # イベント対象のエレメントの一意なセレクタを取得する
  # @param {Object} event
  # @param {Array.<string>} attrSelectors セレクタに使う属性リスト
  # @param {bool} useNthChild セレクタにnth-childを使う
  # @return {string} selector セレクタ(nth-childを使わなければ一意にならない可能性がある)
  @eventToSelector: (event, attrSelectors = ['name', 'type'], useNthChild = true) =>
    selectors = []
    # slice(3) = bodyから
    for index, element of event.path.reverse().slice(3)
      selector = element.localName
      # 属性を付ける
      for attr in element.attributes
        if attrSelectors.indexOf(attr.name) != -1
          selector += "[#{attr.name}='#{attr.value}']"
      # IDを付ける
      if element.id
        selectors = []
        selector += "##{element.id}"
      # IDがない場合
      else
        # 一意判定関数
        uniq = (selector) => return document.querySelectorAll(selector).length == 1
        # 一意ではない場合
        if selectors.length > 0 and !uniq("#{selectors.join(' > ')} > #{selector}")
          # 一意になるまでclassを順次付けていく
          for i, className of element.className.trim().split(' ')
            if className
              selector += ".#{className}"
              break if uniq("#{selectors.join(' > ')} > #{selector}")
          # classだけで一意にならない場合はnth-childを使用する
          if useNthChild and !uniq("#{selectors.join(' > ')} > #{selector}")
            for parent_element in document.querySelectorAll(selectors.join(' > '))
              i = 1
              while i <= parent_element.children.length
                child_elements = document.querySelectorAll("#{selectors.join(' > ')} > #{element.localName}:nth-child(#{i})")
                if child_elements.length == 1 and child_elements[0] == element
                  selector = "#{element.localName}:nth-child(#{i})"
                i++
      selectors.push selector
    selectors.join ' > '

  # エレメントをハイライト表示する。
  # @param {NodeList, Array.<HTMLHeadingElement>, HTMLHeadingElement} elements
  @highlight: (elements) =>
    elements = [elements] if Object.prototype.toString.call(elements) != '[object NodeList]'
    count = 0
    timer = setInterval( ->
      if count > 10
        clearInterval timer
      for element in elements
        style = if count % 2 then 'outline: none' else 'outline: 2px solid red'
        element.setAttribute 'style', style
      count++
    , 500)

  # マウスオーバー中のエレメントをハイライト表示する。
  # @return {function} 停止させる関数
  @highlightMouseoverElement: ()=>
    currentEvent = null
    document.addEventListener 'mouseover', mouseoverEvent = (event) =>
      currentEvent = event
      event.target.setAttribute 'style', 'outline: 1px solid rgb(0,50,100)'
    document.addEventListener 'mouseout', mouseoutEvent = (event) =>
      event.target.setAttribute 'style', 'outline: none'
    return ()=>
      document.removeEventListener('mouseover', mouseoverEvent)
      document.removeEventListener('mouseout', mouseoutEvent)
      currentEvent.target.setAttribute 'style', 'outline: none' if currentEvent

  # background.jsに通知し、stepを保存する
  # @param {Object} step
  @addStep: (steps) =>
    # 配列、単体を受け入れる
    steps = [steps] if not Array.isArray(steps)
    for step in steps
      index = 0
      for key, param of step.params
        param.index = index
        index++
    chrome.runtime.sendMessage
      type: 'addStep'
      value: steps

  # セレクタ取得イベントを追加
  # @param {string} eventName イベント名
  # @param {function} callback コールバック
  # @param {bool} isLoop 連続して入力を受け付けるか
  # @return {function} 停止させる関数
  @addEventListenerSelector: (eventName, callback, isLoop = false) =>
    # マウスオーバー時に要素のセレクタを保存する
    selector = ''
    mouseoverCallback = (event) =>
      selector = @eventToSelector(event)
      if selector != ''
        elements = document.querySelectorAll(selector)
        is_unique = elements.length == 1
        message = if !is_unique then '\nCaution! not unique. count = ' + elements.length else ''
        # console.log '%c' + selector + message, if is_unique then '' else 'color: red'
    # 指定イベントで終了
    eventCallback = (event) =>
      # event.preventDefault()
      selector = @eventToSelector(event)
      if selector != ''
        finish(selector)
    # key Ctrl+Shift+Enterで終了 (クリックなどのイベントはページによってはevent.preventDefault()でキャンセルされる為)
    keyPressed = {}
    keydownCallback = (event) =>
      keyPressed[event.keyCode] = true
      if keyPressed['13'] and keyPressed['16'] and keyPressed['17']
        if selector != ''
          finish(selector)
    keyupCallback = (event) =>
      keyPressed[event.keyCode] = false
    # イベントの登録
    document.addEventListener eventName, eventCallback
    document.addEventListener 'mouseover', mouseoverCallback
    document.addEventListener 'keydown', keydownCallback
    document.addEventListener 'keyup', keyupCallback
    # すべてのイベントを削除する
    removeEvents = ()=>
      document.removeEventListener(eventName, eventCallback)
      document.removeEventListener('mouseover', mouseoverCallback)
      document.removeEventListener('keydown', keydownCallback)
      document.removeEventListener('keyup', keyupCallback)
    # セレクタ取得後、callbackを呼び出す
    finish = (selector) =>
      removeEvents() if not isLoop
      elements = document.querySelectorAll(selector)
      if elements.length != 1
        alert "Not unique. elements count = #{elements.length}"
      else
        callback(eventName, event, selector, elements[0])
    return removeEvents


  # 要素をハイライトする
  # @param {string} step
  @searchElement: (selector) =>
    elements = document.querySelectorAll(selector)
    alert "count = #{elements.length}"
    @highlight(elements)

  # 要素を指定したstepを保存する
  # @param {object} step
  # @return {function} 停止させる関数
  @addElementStep: (step) =>
    highlightMouseoverCancel = @highlightMouseoverElement()
    clickEventCancel = @addEventListenerSelector 'click', (eventName, event, selector, element) =>
      highlightMouseoverCancel()
      clickEventCancel()
      step.params.location.value = selector
      @addStep(step)
      @highlight(element)
    return ()=>
      clickEventCancel()
      highlightMouseoverCancel()

  # 要素を指定したstepを継続して保存する
  # @return {function} 停止させる関数
  @rec: () =>
    # To
    step = new SeleniumCodeBuilder.Step.NavigationToStep
    step.params.url.value = window.location.href
    @addStep(step)
    # Click & DoubleClick
    clickEventCancel = @addEventListenerSelector('click', do ()=>
      clicks = 0
      return (eventName, event, selector, element) =>
        clicks += 1
        setTimeout(()=>
          # single click
          if clicks == 1
            step = new SeleniumCodeBuilder.Step.ElementClickStep
            step.params.location.value = selector
            @addStep(step)
          # double click
          else if clicks == 2
            step = new SeleniumCodeBuilder.Step.ElementDoubleClickStep
            step.params.location.value = selector
            @addStep(step)
          clicks = 0
        , 300)
    , isLoop = true)
    # SendKeys & Select & Check
    changeEventCancel = @addEventListenerSelector('change', (eventName, event, selector, element) =>
      switch event.target.tagName
        when 'INPUT'
          switch event.target.type
            when 'checkbox', 'radio'
              step = new SeleniumCodeBuilder.Step.ElementCheckStep
              step.params.check.value = event.target.checked
            else
              step = new SeleniumCodeBuilder.Step.ElementSendKeysStep
              step.params.input.value = event.target.value
        when 'TEXTAREA'
          step = new SeleniumCodeBuilder.Step.ElementSendKeysStep
          step.params.input.value = event.target.value
        when 'SELECT'
          step = new SeleniumCodeBuilder.Step.ElementSelectStep
          step.params.by.value = 'value'
          step.params.value.value = event.target.value
        else
          return
      step.params.location.value = selector
      @addStep(step)
    , isLoop = true)
    # # DragAndDrop
    # dragAndDropEventCancel = do ()=>
    #   getStep = null
    #   dragEventCancel = @addEventListenerSelector('dragstart', (eventName, event, selector, element) =>
    #     getStep = new SeleniumCodeBuilder.Step.ElementGetStep
    #     getStep.params.location.value = selector
    #     getStep.params.variable.value = 'dragarea'
    #     @addStep(getStep)
    #   , isLoop = true)
    #   dropEventCancel = @addEventListenerSelector('drop', (eventName, event, selector, element) =>
    #     step = new SeleniumCodeBuilder.Step.ElementDragAndDropStep
    #     step.params.location.value = selector
    #     step.params.dragarea.value = 'dragarea'
    #     @addStep([getStep, step])
    #   , isLoop = true)
    #   return ()=>
    #     dragEventCancel()
    #     dropEventCancel()
    return ()=>
      clickEventCancel()
      changeEventCancel()
      # dragAndDropEventCancel()

window.SeleniumCodeBuilder ||= SeleniumCodeBuilder
