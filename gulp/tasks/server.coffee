gulp = require 'gulp'
merge = require 'merge'
connectmodrewrite = require 'connect-modrewrite'
browserSync = require 'browser-sync'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'server', ->
  options = merge({
    server:
      baseDir: config.path.dest,
      directory: false,
      middleware: [
        connectmodrewrite([
          '^[^\\.]*$ /index.html [L]'
        ])
      ]
    notify: false
  }, config.browser)
  options.server = null if options.proxy
  browserSync(options)

gulp.task 'reload', ->
  browserSync.reload()