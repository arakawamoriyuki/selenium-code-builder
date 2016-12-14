module.exports = (config) ->
  config.set
    basePath: ''
    frameworks: ['mocha', 'chai']
    files: [
      # 'src/js/modules/animal.js'
      'test/*.js'
      'test/*.coffee'
    ]
    exclude: [
    ]
    preprocessors: {
      '**/*.coffee': ['coffee', 'sourcemap']
    }
    reporters: ['progress', 'notify']
    port: 9876
    colors: true
    logLevel: config.LOG_INFO
    autoWatch: false
    browsers: ['PhantomJS']
    singleRun: true
    concurrency: Infinity
