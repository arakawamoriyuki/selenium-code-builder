# 拡張が起動中でなくても常時動いているjs

# ページ内で実行しているSeleniumCodeBuilderからステップ追加の通知を受ける
chrome.runtime.onMessage.addListener (request, sender, sendResponse) =>
  if request.type is 'addStep'
    # 配列、単体を受け入れる
    addSteps = if Array.isArray(request.value) then request.value else [request.value]
    chrome.storage.local.get 'steps', (data) =>
      steps = data.steps
      steps ||= []
      chrome.storage.local.get 'indexPoints', (data) =>
        # 挿入位置の指定がある場合
        if data.indexPoints?
          spliceIndex = data.indexPoints.pop()
          innerSteps = {nodes:steps}
          for indexPoint in data.indexPoints
            innerSteps = innerSteps.nodes[indexPoint]
          for step, i in addSteps
            innerSteps.nodes.splice(spliceIndex+1+i, 0, step)
          # 次の挿入位置の補正
          data.indexPoints.push spliceIndex + addSteps.length
          chrome.storage.local.set({'indexPoints': data.indexPoints})
        else
          for step, i in addSteps
            steps.push step
        chrome.storage.local.set({'steps': steps})
        chrome.runtime.sendMessage
          type: 'afterAddStep'

# 画面遷移などで拡張から実行しているSeleniumCodeBuilder.jsが破棄された場合
# 再びSeleniumCodeBuilder.jsを読み込む
# 記録中なら再度記録開始する
chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) =>
  if changeInfo.status == 'loading'
    reloadExtension = (id, rec = false) =>
      chrome.tabs.executeScript id, {file: 'build/js/classes.js'}, (result)=>
        chrome.tabs.executeScript id, {code: "if (!SeleniumCodeBuilder.recCancel) SeleniumCodeBuilder.recCancel = SeleniumCodeBuilder.rec();"} if rec
    chrome.storage.local.get 'startTabId', (data) =>
      reloadExtension(tabId, false) if data.startTabId? and data.startTabId == tabId
    chrome.storage.local.get 'recodingTabId', (data) =>
      reloadExtension(tabId, true) if data.recodingTabId? and data.recodingTabId == tabId

# 記録中のタブが破棄された場合、バッジとStorageの初期化を行う
chrome.tabs.onRemoved.addListener (tabId, removeInfo) =>
  chrome.storage.local.get 'recodingTabId', (data) =>
    if data.recodingTabId? and data.recodingTabId == tabId
      chrome.storage.local.set({'recodingTabId': null})
      chrome.browserAction.setBadgeText({text:''})
