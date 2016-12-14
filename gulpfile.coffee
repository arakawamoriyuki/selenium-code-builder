gulp = require 'gulp'
requireDir = require 'require-dir'

requireDir './gulp/tasks', {recurse: true}

gulp.task 'default', (callback)->
  $.runSequence(
    'build',
    'server',
    'watch',
    callback,
  )