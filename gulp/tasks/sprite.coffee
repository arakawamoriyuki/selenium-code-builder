gulp = require 'gulp'
merge = require 'merge'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'sprite', ->
  assetsRoot = "#{config.path.dest.replace(///#{config.browser.server.baseDir}\/?///g, '')}"
  spriteData = gulp.src("#{config.path.src}/#{config.image.sprite.dir}/*.png")
    .pipe $.spritesmith(
      merge({
        imgName: 'sprite.png'
        imgPath: "/#{assetsRoot}/#{config.image.sprite.dir}/#{config.image.sprite.options.imgName}"
        cssName: 'sprite.css'
      }, config.image.sprite.options)
    )
  spriteData.img.pipe gulp.dest("#{config.path.dest}/#{config.image.sprite.dir}")
  spriteData.css.pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")