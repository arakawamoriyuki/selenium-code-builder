# 処理が完了するまで円形プログレスを表示する
window.app.factory 'Progress', ['$mdDialog', '$timeout', ($mdDialog, $timeout)->
  # 関数かPromiseオブジェクトを受け付ける
  return (promise) =>
    $mdDialog.show
      templateUrl: 'dialog/progress.html'
      parent: angular.element(document.body)
      clickOutsideToClose: false
      fullscreen: false
      onComplete: ()=>
        # $timeoutの戻り値はDOMの反映後にresolveされるPromiseオブジェクト
        promise = $timeout(promise) if typeof promise == "function"
        promise.then ()=>
          $mdDialog.hide()
]
