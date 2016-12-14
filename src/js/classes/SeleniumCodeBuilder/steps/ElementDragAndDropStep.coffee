class SeleniumCodeBuilder.Step.ElementDragAndDropStep extends SeleniumCodeBuilder.Step

  @Name: 'Drag and Drop'
  @Tips:
    Description: '要素を指定の場所へドラッグする'
    Params:
      location:   'CSSセレクタ'
      dragarea:   'ドラッグ箇所(Element->Getで取得した変数を指定してください)'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      location:   SeleniumCodeBuilder.Input.text()
      dragarea:   SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.action.drag_and_drop(_wait.until { _driver.find_element(css: #{@params['location'].value}) }, #{@params['dragarea'].value}).perform
"""
      when "python"
        return """
#{tab}ActionChains(_driver).drag_and_drop(_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value})), #{@params['dragarea'].value}).perform()
"""
