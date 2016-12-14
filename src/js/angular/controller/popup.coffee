window.app.controller 'PopupController',
['$mdDialog',
'SeleniumCodeBuilderService', 'StepService', 'LocalFile', 'Download', 'Upload', 'Progress', 'Extension', 'CommandDialog', 'ConvertDialog',
(@$mdDialog,
@SeleniumCodeBuilderService, @StepService, @LocalFile, @Download, @Upload, @Progress, @Extension, @CommandDialog, @ConvertDialog) ->
  
  # 使い方
  @howToUse = ()=>
    @$mdDialog.show
      templateUrl: 'dialog/howtouse.html'
      controller: ['$scope', '$mdDialog', (_$scope, _$mdDialog) => _$scope.close = _$mdDialog.hide]

  # セレクタの検索
  @searchElement = (selector) =>
    @SeleniumCodeBuilderService.searchElement(selector)

  # 記録中判定
  @isRec = () =>
    @SeleniumCodeBuilderService.isRec()

  # ブラウザ操作の記録の開始
  @recStart = () =>
    @SeleniumCodeBuilderService.recStart()

  # ブラウザ操作の記録の停止
  @recStop = () =>
    @SeleniumCodeBuilderService.recStop()

  # ステップの保存
  @saveSteps = (steps) =>
    @StepService.setSteps(steps)
    @StepService.saveSteps()

  # ステップの削除
  @deleteStep = (scope) =>
    @StepService.deleteStep(scope)

  # 全ステップの削除
  @reset = () =>
    @$mdDialog.show(@$mdDialog.confirm
      title: '作業内容が失われますがよろしいですか？'
      textContent: "現在編集中のステップをすべて削除します。"
      ok: 'OK'
      cancel: 'キャンセル'
    ).then ()=>
      @Progress ()=>
        @StepService.reset()

  # steps.jsonを開く
  @open = () =>
    @Upload('.json').then (text)=>
      @$mdDialog.show(@$mdDialog.confirm
        title: '作業内容が失われますがよろしいですか？'
        textContent: "他のステップを開くと現在編集中のステップを上書きします。\n保存後に利用してください。"
        ok: 'OK'
        cancel: 'キャンセル'
      ).then ()=>
        @Progress ()=>
          @StepService.setSteps(angular.fromJson(text))
          @StepService.saveSteps()

  # Steps.jsonをエクスポート
  @export = () =>
    @Download(angular.toJson(@StepService.getSteps(), true), 'steps.json')

  # テストコード変換ダイアログを開く
  @openConvertDialog = () =>
    @ConvertDialog(@StepService.getSteps()).then (config)=>
      if config?
        @StepService.compile(config).then (testCode)=>
          # 使用方法の案内
          @CommandDialog(config)
          @Download(testCode, 'steps.txt') # TODO: セキュリティ上の理由で.rbがdownloadできない

  # シングルトンクラスダウンロードダイアログを開く
  @openSingletonDialog = () =>
    @$mdDialog.show(
      templateUrl:'dialog/singleton.html'
      controller: 'SingletonDialogController'
    ).then (langage)=>
      if langage?
        @LocalFile("/templates/#{langage.toLowerCase()}/context.#{@Extension(langage)}").then (content) =>
          @Download(content, 'context.txt') # TODO: セキュリティ上の理由で.rbがdownloadできない

  # return void
  return
]
