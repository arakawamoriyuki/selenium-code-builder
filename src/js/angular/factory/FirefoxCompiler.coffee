# BaseCompilerを継承したFirefox用のコンパイラ
window.app.factory 'FirefoxCompiler', ['$q', 'StepCompiler', 'LocalFile', 'Extension', 'BaseCompiler', ($q, StepCompiler, LocalFile, Extension, BaseCompiler)->
  class FirefoxCompiler extends BaseCompiler
    default: () =>
      environment:  'ruby'
      platformName: 'firefox'
      waitTimeout:  10

  return new FirefoxCompiler($q, StepCompiler, LocalFile, Extension)
]