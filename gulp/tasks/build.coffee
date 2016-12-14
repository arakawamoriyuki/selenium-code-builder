gulp = require 'gulp'
$ = require('gulp-load-plugins')()
deleteEmpty = require('delete-empty')
config = require '../config.coffee'

gulp.task 'build', (callback)->
  $.runSequence(
    'clean',
    ['bower', 'sprite']
    'compress',
    ['lint', 'compile']
    'concat',
    'minify',
    'delete_empty',
    'test_onetime',
    callback
  )

gulp.task 'bower', ->
  $.bower('bower_components')
    .pipe gulp.dest("#{config.path.dest}/#{config.bower.dir}")

gulp.task 'delete_empty', ->
  deleteEmpty.sync("#{config.path.dest}/#{config.js.dir}")
  deleteEmpty.sync("#{config.path.dest}/#{config.css.dir}")
  deleteEmpty.sync("#{config.path.dest}/#{config.image.dir}")