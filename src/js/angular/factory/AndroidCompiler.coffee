# BaseCompilerを継承したAndroid用のコンパイラ
window.app.factory 'AndroidCompiler', ['$q', 'StepCompiler', 'LocalFile', 'Extension', 'BaseCompiler', ($q, StepCompiler, LocalFile, Extension, BaseCompiler)->
  class AndroidCompiler extends BaseCompiler
    default: () =>
      environment:      'ruby'
      platformName:     'android'
      platformVersion:  ''
      deviceName:       ''
      automationName:   'Appium'
      browserName:      'Browser'
      language:         'ja'
      locale:           'JP'
      waitTimeout:      10

    before: (config) =>
      config = @createConfig(config)

      suffix = if config.automationName is 'Selendroid(standalone)' then '_selendroid_standalone' else '_appium'

      @$q (resolve)=>
        @LocalFile("/templates/#{config.environment}/before/#{config.platformName}#{suffix}.#{@Extension(config.environment)}", @replaces(config)).then (code)=>
          resolve(code)

  return new AndroidCompiler($q, StepCompiler, LocalFile, Extension)
]