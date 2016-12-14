gulp = require 'gulp'
streamMerge = require('merge-stream')
del = require 'del'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'concat', (callback)->
  $.runSequence(
    ['js_concat', 'css_concat'],
    ['js_concat_clean', 'css_concat_clean'],
    callback
  )

gulp.task 'js_concat', ->
  stream = null
  for name, concatFiles of config.js.concat
    concatFiles = concatFiles.map (file)=> "#{config.path.dest}/#{config.js.dir}/#{file}"
    _stream = gulp.src(concatFiles)
      .pipe $.concat(name)
      .pipe gulp.dest("#{config.path.dest}/#{config.js.dir}")
    stream = if stream? then streamMerge(stream, _stream) else _stream
  return stream

gulp.task 'js_concat_clean', (callback)->
  delConfig = []
  for name, concatFiles of config.js.concat
    for file in concatFiles
      delConfig.push "#{config.path.dest}/#{config.js.dir}/#{file}"
    delConfig.push "!#{config.path.dest}/#{config.js.dir}/#{name}"
  del(delConfig, callback)

gulp.task 'css_concat', ->
  stream = null
  for name, concatFiles of config.css.concat
    concatFiles = concatFiles.map (file)=> "#{config.path.dest}/#{config.css.dir}/#{file}"
    _stream = gulp.src(concatFiles)
      .pipe $.concat(name)
      .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")
    stream = if stream? then streamMerge(stream, _stream) else _stream
  return stream

gulp.task 'css_concat_clean', (callback)->
  delConfig = []
  for name, concatFiles of config.css.concat
    for file in concatFiles
      delConfig.push "#{config.path.dest}/#{config.css.dir}/#{file}"
    delConfig.push "!#{config.path.dest}/#{config.css.dir}/#{name}"
  del(delConfig, callback)