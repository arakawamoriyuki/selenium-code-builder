gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'lint', ['js_lint', 'css_lint']

gulp.task 'js_lint', ->
  gulp.src("#{config.path.src}/#{config.js.dir}/**/*.js")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.jshint()
    .pipe $.jshint.reporter('jshint-stylish')
    .pipe gulp.dest("#{config.path.dest}/#{config.js.dir}")

gulp.task 'css_lint', ->
  gulp.src("#{config.path.src}/#{config.css.dir}/**/*.css")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.csslint()
    .pipe $.csslint.reporter()
    .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")