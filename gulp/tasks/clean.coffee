gulp = require 'gulp'
del = require 'del'
config = require '../config.coffee'

gulp.task 'clean', del.bind(null, [
  "#{config.path.dest}/#{config.js.dir}"
  "#{config.path.dest}/#{config.css.dir}"
  "#{config.path.dest}/#{config.image.dir}"
  "#{config.path.dest}/#{config.bower.dir}"
])