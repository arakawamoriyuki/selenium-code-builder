gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'watch', ->
  gulp.watch "**/*.html", ->
    $.runSequence('reload')

  gulp.watch "#{config.path.src}/#{config.image.sprite.dir}/*.png", ->
    $.runSequence('sprite', 'css_minify', 'reload')

  gulp.watch "#{config.path.src}/#{config.image.dir}/*.png", ->
    $.runSequence('compress', 'reload')

  gulp.watch "#{config.path.src}/#{config.js.dir}/**/*.js", ->
    $.runSequence('js_lint', 'babel', 'js_minify', 'js_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.js.dir}/**/*.coffee", ->
    $.runSequence('coffee', 'js_minify', 'js_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.js.dir}/**/*.ts", ->
    $.runSequence('typescript', 'js_minify', 'js_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.css.dir}/**/*.css", ->
    $.runSequence('css_lint', 'css_minify', 'css_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.css.dir}/**/*.sass", ->
    $.runSequence('sass', 'css_minify', 'css_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.css.dir}/**/*.scss", ->
    $.runSequence('scss', 'css_minify', 'css_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.css.dir}/**/*.less", ->
    $.runSequence('less', 'css_minify', 'css_concat', 'reload')

  gulp.watch "#{config.path.src}/#{config.css.dir}/**/*.styl", ->
    $.runSequence('stylus', 'css_minify', 'css_concat', 'reload')