module.exports =
  path:
    src: 'src'
    dest: 'build'
  js:
    dir: 'js'
    minify: ['**/*.js']
    concat:
      'classes.js' : [
        'classes/**/*.js'
      ]
      'angular-modules.js' : [
        'angular/directive/**/*.js'
        'angular/factory/**/*.js'
        'angular/filter/**/*.js'
        'angular/service/**/*.js'
      ]
      'angular-controllers.js' : [
        'angular/controller/**/*.js'
      ]
  css:
    dir: 'css'
    minify: ['**/*.css']
    concat: {}
  image:
    dir: 'images'
    # imagemin-pngquant設定
    options:
      quality: '60-80'
      speed: 1
    sprite:
      dir: 'images/sprite'
      # gulp-spritesmith設定
      options:
        imgName: 'sprite.png'
        cssName: 'sprite.css'
  bower:
    dir: 'lib'
  # browser-sync設定
  browser:
    server:
      baseDir: ''
    ghostMode:
      clicks: false
      location: false
      forms: false
      scroll: false