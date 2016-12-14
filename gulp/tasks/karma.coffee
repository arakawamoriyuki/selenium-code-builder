gulp = require 'gulp'
karma = require('karma');
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'test', ()=>
  new karma.Server(
    configFile: "#{process.cwd()}/karma.conf.coffee"
    singleRun: false
    autoWatch: true
  ).start()

gulp.task 'test_onetime', ()=>
  new karma.Server(
    configFile: "#{process.cwd()}/karma.conf.coffee"
    singleRun: true
    autoWatch: false
  ).start()