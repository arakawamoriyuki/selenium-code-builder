gulp = require 'gulp'
streamMerge = require('merge-stream')
del = require 'del'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'minify', (callback)->
  $.runSequence(
    ['js_minify', 'css_minify'],
    ['js_minify_clean', 'css_minify_clean'],
    callback
  )

gulp.task 'js_minify', ->
  stream = null
  for minifyFile in config.js.minify
    _stream = gulp.src(["#{config.path.dest}/#{config.js.dir}/#{minifyFile}", "!#{config.path.dest}/#{config.js.dir}/**/*.min.js"])
      .pipe $.jsmin()
      .pipe $.rename({suffix: '.min'})
      .pipe gulp.dest("#{config.path.dest}/#{config.js.dir}")
    stream = if stream? then streamMerge(stream, _stream) else _stream
  return stream

gulp.task 'js_minify_clean', (callback)->
  delConfig = config.js.minify.map (file)=> "#{config.path.dest}/#{config.js.dir}/#{file}"
  delConfig.push "!#{config.path.dest}/#{config.js.dir}/**/*.min.js"
  del(delConfig, callback)

gulp.task 'css_minify', ->
  stream = null
  for minifyFile in config.css.minify
    _stream = gulp.src(["#{config.path.dest}/#{config.css.dir}/#{minifyFile}", "!#{config.path.dest}/#{config.css.dir}/**/*.min.css"])
      .pipe $.cssmin()
      .pipe $.rename({suffix: '.min'})
      .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")
    stream = if stream? then streamMerge(stream, _stream) else _stream
  return stream

gulp.task 'css_minify_clean', (callback)->
  delConfig = config.css.minify.map (file)=> "#{config.path.dest}/#{config.css.dir}/#{file}"
  delConfig.push "!#{config.path.dest}/#{config.css.dir}/**/*.min.css"
  del(delConfig, callback)