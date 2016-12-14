# BaseCompiler
window.app.factory 'BaseCompiler', [()->
  class BaseCompiler

    constructor: (@$q, @StepCompiler, @LocalFile, @Extension) ->

    default: () =>
      environment:  'ruby'
      platformName: 'chrome'
      waitTimeout:  10

    createConfig: (config) =>
      angular.extend(@default(), config)

    replaces: (config) =>
      result = {}
      for key, value of config
        result["__#{key.toUpperCase()}__"] = value
      result

    before: (config) =>
      config = @createConfig(config)
      @LocalFile("/templates/#{config.environment}/before/#{config.platformName}.#{@Extension(config.environment)}", @replaces(config))

    after: (config) =>
      config = @createConfig(config)
      @LocalFile("/templates/#{config.environment}/after/common.#{@Extension(config.environment)}", @replaces(config))

    compile: (steps, config) =>
      config = @createConfig(config)
      _compile = (_steps, depth = 0)=>
        result = ''
        for step in _steps
          stepCompiler = new @StepCompiler(step)
          innerCode = if stepCompiler.isInnerCode() then _compile(step.nodes, depth+1) else ''
          result += "#{stepCompiler.to(config.environment, depth, innerCode)}\n"
        return result
      defer = @$q.defer()
      defer.resolve(_compile(angular.copy(steps)))
      defer.promise
]