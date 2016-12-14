# ファイルアップロード画面を表示、値を返すPromiseオブジェクトを返す
window.app.factory 'Upload', ['$q', '$timeout', ($q, $timeout)->
  return (accept = '') =>
    deferred = $q.defer()
    input = angular.element(document.createElement('input'))
    $timeout(()=>
      input.attr('type', 'file')
      input.attr('value', '')
      input.attr('accept', accept)
      input.change () =>
        file = input.prop('files')[0]
        fileReader = new FileReader
        fileReader.readAsText(file)
        fileReader.onload = (event)=>
          deferred.resolve(fileReader.result)
    ).then ()=>
      input.trigger('click')
    deferred.promise
]
