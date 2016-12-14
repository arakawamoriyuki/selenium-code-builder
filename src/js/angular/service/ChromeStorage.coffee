# chrome拡張内のデータ永続化
window.app.service 'ChromeStorage', ['$q', 'Chrome', class ChromeStorage

  constructor: (@$q, @Chrome) ->

  get: (key) =>
    defer = @$q.defer()
    @Chrome.storage.local.get key, (data) =>
      defer.resolve(if data[key]? then data[key] else null)
    defer.promise

  set: (key, value) =>
    defer = @$q.defer()
    @Chrome.storage.local.set {"#{key}" : value}, ()=>
      defer.resolve()
    defer.promise

]