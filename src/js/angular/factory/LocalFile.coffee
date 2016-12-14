# 拡張内のファイルをreplacesで置換してPromiseオブジェクトを返す
window.app.factory 'LocalFile', ['$q', '$http', ($q, $http)->
  return (path, replaces = {}) =>
    deferred = $q.defer()
    $http.get(path).then (data, status, headers, config)=>
      content = data.data
      for before, after of replaces
        content = content.replace(new RegExp(before, 'g'), after)
      deferred.resolve(content)
    deferred.promise
]