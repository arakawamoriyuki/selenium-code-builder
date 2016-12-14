# 拡張内のStepリストの管理
window.app.service 'StepService', ['$q', '$mdToast', 'SeleniumCodeBuilderService', 'Compiler', 'Chrome', 'ChromeStorage', 'Key', 'Progress', class StepService

  constructor: (@$q, @$mdToast, @SeleniumCodeBuilderService, @Compiler, @Chrome, @ChromeStorage, @Key, @Progress) ->

    # ステップ
    @steps = []

    # 選択中のステップのスコープ
    @selectedScopes = []

    # クリップボードに保存したステップ
    @clipboardSteps = []

    # キャッシュとして持つ操作履歴
    @cacheSteps = []
    @cacheStepsCurrentIndex = -1

    # ショートカットの登録
    @Key.setCopy ()=> @copy().then ()=> @$mdToast.show(@$mdToast.simple('Step(s) copied').hideDelay(1000))
    @Key.setPaste ()=> @paste().then ()=> @$mdToast.show(@$mdToast.simple('Step(s) pasted').hideDelay(1000))
    @Key.setUndo(@undo)
    @Key.setRedo(@redo)

    # ステップのロード
    @Progress(@reloadSteps())

    # background.js用のステップ挿入位置の初期化
    @ChromeStorage.set('indexPoints', null)

    # background.jsからメッセージを受け取る
    @Chrome.runtime.onMessage.addListener (request, sender, sendResponse) =>
      # 要素選択後、リストを更新する
      @reloadSteps() if request.type is 'afterAddStep'

  # ステップの取得
  getSteps: ()=>
    @steps

  # ステップのセット
  setSteps: (steps)=>
    @steps = steps

  # ステップの更新
  reloadSteps: () =>
    defer = @$q.defer()
    @ChromeStorage.get('steps').then (steps)=>
      steps = [] if steps is null
      @setSteps(steps)
      @addCacheSteps(steps)
      defer.resolve()
    defer.promise

  # クラスからステップを追加する
  addStepClass: (StepClass, recElement = false) =>
    step = new StepClass
    if recElement
      @SeleniumCodeBuilderService.addElementStep(step)
    else
      @addStep(step)

  # ステップを追加する
  addStep: (steps) =>
    # 配列、単体を受け入れる
    steps = [steps] if not angular.isArray(steps)
    # 選択中のstepがあればその下に追加
    if @selectedScopes.length > 0
      # 最後に選択したStepの下に配置する
      targetScope = @selectedScopes[0]
      if targetScope.$parentNodeScope != null
        index = targetScope.$parentNodeScope.childNodes().indexOf(targetScope)
        spliceTarget = targetScope.$parentNodeScope.$modelValue.nodes
      else
        index = @steps.indexOf(targetScope.$modelValue)
        spliceTarget = @steps
      for step, i in steps
        spliceTarget.splice(index+1+i, 0, step)
    # 選択中のstepがなければ一番下に追加
    else
      for step in steps
        @steps.push step
    @saveSteps()

  # ステップを保存する
  saveSteps: () =>
    @addCacheSteps angular.copy(@steps)
    @ChromeStorage.set('steps', angular.copy(@steps))

  # 元に戻す用キャッシュを追加
  addCacheSteps: (steps) =>
    if @cacheStepsCurrentIndex != @cacheSteps.length-1
      @cacheSteps = @cacheSteps.slice(0, @cacheStepsCurrentIndex+1)
    @cacheSteps.push steps
    @cacheStepsCurrentIndex++
    if @cacheSteps.length > 100 # 100回分の操作をキャッシュする
      @cacheSteps.shift()
      @cacheStepsCurrentIndex--

  # ステップの選択
  selectScope: (scope, $event) =>
    $event.stopPropagation()
    # 選択済みのステップを選択
    if @selectedScopes.indexOf(scope) != -1
      # 複数のステップが選択済み
      if @selectedScopes.length > 1
        # Shiftを押していればそのステップを解除
        if @Key.isKeyDown(@Key.KeyCode.Shift)
          @selectedScopes.splice(@selectedScopes.indexOf(scope), 1)
        # そのステップを選択
        else
          @selectedScopes = [scope]
      # 一つのステップが選択済み
      else if @selectedScopes.length == 1
        @selectedScopes = []
    # 新たにステップを選択
    else
      # Shiftキーを押していなければ全解除
      @selectedScopes = [] if !@Key.isKeyDown(@Key.KeyCode.Shift)
      @selectedScopes.unshift scope
      # 最後に選択したStepの下に配置する
      @ChromeStorage.set('indexPoints', @getIndexPoints(@selectedScopes[0]))

  # ステップの削除
  deleteStep: (scope) =>
    if @selectedScopes.indexOf(scope) != -1
      @selectedScopes.splice(@selectedScopes.indexOf(scope), 1)
    scope.remove()
    @saveSteps()

  # ステップ全削除
  reset: ()=>
    @steps = []
    @saveSteps()

  # テストコードに変換
  compile: (config)=>
    @Compiler(@steps, config)

  # angular-ui-treeのnestされたscopeを含め、渡されたscopeの位置を配列で返す
  # nestedScopes = [scope, [[scope, scope, targetScope], scope], scope]
  # getIndexPoints(nestedScopes[1][0][2])
  # => [1, 0, 2]
  getIndexPoints: (scope, indexPoints = [])=>
    if scope.$parentNodeScope != null
      indexPoints.unshift scope.$parentNodeScope.childNodes().indexOf(scope)
      indexPoints = @getIndexPoints(scope.$parentNodeScope, indexPoints)
    else
      indexPoints.unshift @steps.indexOf(scope.$modelValue)
    return indexPoints

  ## -- ショートカット --

  # ステップをクリップボードにコピーする
  copy: ()=>
    deferred = @$q.defer()
    if @selectedScopes.length > 0
      @clipboardSteps = []
      # 選択されたscopeの値とネストされた位置を取得
      selectedModels = @selectedScopes.map (selectedScope) =>
        return selectedModel =
          indexPoints: @getIndexPoints(selectedScope)
          value: selectedScope.$modelValue
      # ソート
      selectedModels.sort (a, b)=>
        minLength = Math.min(a.indexPoints.length, b.indexPoints.length)
        # 親を辿ってソート
        for index in [0..minLength-1]
          if a.indexPoints[index] != b.indexPoints[index]
            return if a.indexPoints[index] > b.indexPoints[index] then 1 else -1
        # 親と子の関係だった場合、親が優先
        return if a.indexPoints.length > b.indexPoints.length then 1 else -1
      for selectedModel in selectedModels
        @clipboardSteps.push selectedModel.value
      deferred.resolve()
    deferred.promise

  # クリップボードのステップ貼り付ける
  paste: ()=>
    deferred = @$q.defer()
    if @clipboardSteps.length > 0
      @addStep(angular.copy(@clipboardSteps))
      deferred.resolve()
    deferred.promise

  # 元に戻す
  undo: ()=>
    deferred = @$q.defer()
    if @cacheSteps[@cacheStepsCurrentIndex-1]?
      @cacheStepsCurrentIndex--
      @steps = angular.copy(@cacheSteps[@cacheStepsCurrentIndex])
      deferred.resolve()
    deferred.promise

  # やり直す
  redo: ()=>
    deferred = @$q.defer()
    if @cacheSteps[@cacheStepsCurrentIndex+1]?
      @cacheStepsCurrentIndex++
      @setSteps(angular.copy(@cacheSteps[@cacheStepsCurrentIndex]))
      deferred.resolve()
    deferred.promise

]