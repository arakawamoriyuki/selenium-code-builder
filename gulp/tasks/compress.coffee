gulp = require 'gulp'
merge = require 'merge'
pngquant = require 'imagemin-pngquant'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'compress', ->
  options = merge({
    quality: '60-80'
    speed: 1
  }, config.image.options)
  gulp.src(["#{config.path.src}/#{config.image.dir}/**/*", "!#{config.path.src}/#{config.image.sprite.dir}/*"])
    .pipe $.imagemin(use: pngquant(options))
    .pipe gulp.dest "#{config.path.dest}/#{config.image.dir}"