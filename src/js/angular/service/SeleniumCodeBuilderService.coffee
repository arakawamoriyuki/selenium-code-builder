# 操作の記録やCSSセレクタの取得の為に、拡張から対象のページでjsを実行する
# js/classes/SeleniumCodeBuilder.js
window.app.service 'SeleniumCodeBuilderService', ['$q', '$window', 'Chrome', 'ChromeStorage', class SeleniumCodeBuilderService

  constructor: (@$q, @$window, @Chrome, @ChromeStorage) ->

    @recodingTabId = null
    @startTabId = null

    @$q.all([
      # レコーディング中のタブID取得
      @ChromeStorage.get('recodingTabId').then((recodingTabId)=> @recodingTabId = recodingTabId),
      # 拡張を開いた際のタブID取得
      @ChromeStorage.get('startTabId').then((startTabId)=> @startTabId = startTabId),
    ]).then ()=>
      # ターゲットが存在しない場合windowを閉じる
      @$window.close() if @getTabId() == null
      # 有効でない場合windowを閉じる
      @Chrome.tabs.get @getTabId(), ()=>
        if @Chrome.runtime.lastError
          @recStop()
          @$window.close()
      # 対象のページが閉じられた場合、拡張も閉じる
      @Chrome.tabs.onRemoved.addListener (tabId, removeInfo)=>
        @$window.close() if @getTabId() == tabId
      # 現在のページにSeleniumCodeBuilder.jsを読み込ませる
      @Chrome.tabs.executeScript @getTabId(), {file: 'build/js/classes.min.js'}
      # ハイライト
      @Chrome.tabs.get @getTabId(), (tab) =>
        @Chrome.tabs.highlight {'tabs': tab.index, 'windowId':tab.windowId}

  # 対象のタブIDを取得する(記録のIDを、なければ拡張起動時のIDを返す)
  getTabId: ()=>
    return if @recodingTabId? then @recodingTabId else @startTabId

  # 記録中判定
  isRec: ()=>
    @recodingTabId?

  # セレクタの検索
  searchElement: (selector)=>
    @Chrome.tabs.executeScript @getTabId(), {code: 'SeleniumCodeBuilder.searchElement("'+selector+'")'}

  # ブラウザから要素を取得してStepを追加する
  addElementStep: (step)=>
    @Chrome.tabs.executeScript @getTabId(), {code: "SeleniumCodeBuilder.addElementStep(#{JSON.stringify(step)})"}

  # ブラウザ操作の記録の開始
  recStart: () =>
    if @recodingTabId == null
      @recodingTabId = angular.copy(@startTabId)
      @ChromeStorage.set('recodingTabId', @recodingTabId)
      @Chrome.browserAction.setBadgeText({text:'REC'})
      @Chrome.tabs.executeScript @recodingTabId, {code: "if (!SeleniumCodeBuilder.recCancel) SeleniumCodeBuilder.recCancel = SeleniumCodeBuilder.rec();"}

  # ブラウザ操作の記録の停止
  recStop: () =>
    if @recodingTabId != null
      @Chrome.tabs.executeScript @recodingTabId, {code: "if (SeleniumCodeBuilder.recCancel) SeleniumCodeBuilder.recCancel(); SeleniumCodeBuilder.recCancel = null;"}
      @recodingTabId = null
      @ChromeStorage.set('recodingTabId', @recodingTabId)
      @Chrome.browserAction.setBadgeText({text:''})
]