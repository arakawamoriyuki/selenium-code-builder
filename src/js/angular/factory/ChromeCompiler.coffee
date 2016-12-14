# BaseCompilerを継承したChrome用のコンパイラ
window.app.factory 'ChromeCompiler', ['$q', 'StepCompiler', 'LocalFile', 'Extension', 'BaseCompiler', ($q, StepCompiler, LocalFile, Extension, BaseCompiler)->
  class ChromeCompiler extends BaseCompiler
    default: () =>
      environment:        'ruby'
      platformName:       'chrome'
      waitTimeout:        10
      allRangeScreenshot: false

    before: (config) =>
      config = @createConfig(config)

      prefix = if config.allRangeScreenshot then '_custom_driver' else ''

      @$q (resolve)=>
        @LocalFile("/templates/#{config.environment}/before/#{config.platformName}#{prefix}.#{@Extension(config.environment)}", @replaces(config)).then (code)=>
          resolve(code)


  return new ChromeCompiler($q, StepCompiler, LocalFile, Extension)
]