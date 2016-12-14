gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config.coffee'

gulp.task 'compile', ['babel', 'typescript', 'coffee', 'less', 'sass', 'scss', 'stylus']

gulp.task 'babel', ->
  gulp.src("#{config.path.src}/#{config.js.dir}/**/*.js")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.babel(presets: ['es2015'])
    .pipe gulp.dest("#{config.path.dest}/#{config.js.dir}")

gulp.task 'typescript', ->
  gulp.src("#{config.path.src}/#{config.js.dir}/**/*.ts")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.typescript()
    .pipe gulp.dest("#{config.path.dest}/#{config.js.dir}")

gulp.task 'coffee', ->
  gulp.src("#{config.path.src}/#{config.js.dir}/**/*.coffee")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.sourcemaps.init()
    .pipe $.coffee()
    .pipe $.sourcemaps.write()
    .pipe gulp.dest("#{config.path.dest}/#{config.js.dir}")

gulp.task 'less', ->
  gulp.src("#{config.path.src}/#{config.css.dir}/**/*.less")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.sourcemaps.init()
    .pipe $.less()
    .pipe $.autoprefixer()
    .pipe $.sourcemaps.write()
    .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")

gulp.task 'sass', ->
  gulp.src("#{config.path.src}/#{config.css.dir}/**/*.sass")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.sourcemaps.init()
    .pipe $.sass({
      indentedSyntax: true
      errLogToConsole: true
    })
    .pipe $.autoprefixer()
    .pipe $.sourcemaps.write()
    .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")

gulp.task 'scss', ->
  gulp.src("#{config.path.src}/#{config.css.dir}/**/*.scss")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.sourcemaps.init()
    .pipe $.sass({
      indentedSyntax: true
      errLogToConsole: true
    })
    .pipe $.autoprefixer()
    .pipe $.sourcemaps.write()
    .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")

gulp.task 'stylus', ->
  gulp.src("#{config.path.src}/#{config.css.dir}/**/*.styl")
    .pipe $.plumber({errorHandler: $.notify.onError('Error: <%= error.message %>')})
    .pipe $.sourcemaps.init()
    .pipe $.stylus()
    .pipe $.autoprefixer()
    .pipe $.sourcemaps.write()
    .pipe gulp.dest("#{config.path.dest}/#{config.css.dir}")