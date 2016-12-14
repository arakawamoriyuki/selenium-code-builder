# /templates内のテストコードテンプレートを置換してPromiseで返す
window.app.factory 'Compiler', ['$q', 'ChromeCompiler', 'FirefoxCompiler', 'AndroidCompiler', ($q, ChromeCompiler, FirefoxCompiler, AndroidCompiler)->
  return (steps, config)=>

    compiler = null
    switch config.platformName
      when 'chrome'
        compiler = ChromeCompiler
      when 'firefox'
        compiler = FirefoxCompiler
      when 'android'
        compiler = AndroidCompiler

    defer = $q.defer()
    $q.all([
      compiler.before(config),
      compiler.compile(steps, config),
      compiler.after(config),
    ]).then (result)=>
      # result[0] = インポートやwebdriverのインスタンスなどの前処理
      # result[1] = 各ステップをコードに変換した結果
      # result[2] = webdriverを閉じる後処理
      defer.resolve(result.join(''))

    # promiseを返却
    return defer.promise
]