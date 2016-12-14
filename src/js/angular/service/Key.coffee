# angular-hotkeysを使ったショートカットの登録サービス
window.app.service 'Key', ['$document', 'hotkeys', class Key

  constructor: ($document, @hotkeys) ->

    @KeyCode =
      Shift: 16
    @pressKeys = []

    $document.bind 'keydown', @keydown
    $document.bind 'keyup', @keyup

  # angular-hotkeys、コピーショートカットの登録
  setCopy: (callable) => @hotkeys.add 'ctrl+c', null, callable

  # angular-hotkeys、ペーストショートカットの登録
  setPaste: (callable) => @hotkeys.add 'ctrl+v', null, callable

  # angular-hotkeys、undoショートカットの登録
  setUndo: (callable) => @hotkeys.add 'ctrl+z', null, callable

  # angular-hotkeys、redoショートカットの登録
  setRedo: (callable) => @hotkeys.add 'ctrl+shift+z', null, callable

  isKeyDown: (keycode) => @pressKeys.indexOf(keycode.toString()) != -1
  isKeyUp: (keycode) => @pressKeys.indexOf(keycode.toString()) == -1
  keydown: (event) => @pressKeys.push event.keyCode.toString() if @isKeyUp(event.keyCode)
  keyup: (event) => @pressKeys.splice(@pressKeys.indexOf(event.keyCode.toString()), 1) if @isKeyDown(event.keyCode)

]