chrome.storage.local.set
  'startTabId': null

chrome.tabs.query
  title:  'Selenium Code Builder'
  url:    'chrome-extension://*/src/views/popup.html'
, (tabs) =>
  # 既に起動済みの場合、アクティブにする
  if tabs.length > 0
    chrome.windows.update(tabs[0].windowId, { focused: true })
    window.close()
  # 起動していない場合、開く
  else
    chrome.tabs.query
      currentWindow:  true
      active:         true
    , (tabs) =>
      if tabs.length == 1
        # 拡張を開いた際のカレントタブIDを保存
        chrome.storage.local.set
          'startTabId': tabs[0].id
        # メイン画面を表示
        chrome.windows.create
          url:      'src/views/popup.html'
          focused:  true
          type:     'panel'
          width:    650
          height:   800
        , (newWindow) =>
          window.close()
          chrome.windows.update(newWindow.id, { focused: true })