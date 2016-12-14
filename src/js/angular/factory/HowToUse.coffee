# 変換時の元に実行手順の案内を返す
window.app.factory 'HowToUse', [()->
  return (config) =>
    class HowToUse
      constructor: (@config) ->

        @preparations = []
        @runCommands = []
        @exitCommands = []

        switch @config['platformName']
          when 'android'
            @preparations.push 'Android SDKにパスを通し、adbコマンドが使用できる事を確認してください。'
            @runCommands.push
              descriptions: [
                'Android端末をUSBデバッグを有効にしてPCを接続します。',
                '`adb devices`コマンドで端末が接続されているか確認してください。',
                'ネットワーク越しにadb接続する場合は下記のコマンドで接続してください。xxxxは適宜読み替えてください。',
              ]
              command: 'adb connect xxxx'
            switch @config['browserName']
              when 'Selendroid(standalone)'
                @preparations.push 'selendroid-standalone.jarをダウンロードしてください。'
                @runCommands.push
                  descriptions: [
                    '2.3以上のAndroidを操作するselendroidサーバーを起動します。',
                    'selendroid-standalone.jarを保存したディレクトリに`cd`コマンドで移動して下記コマンドを実行します。',
                    'xは適宜バージョンを読み替えてください。',
                  ]
                  command: 'java -jar selendroid-standalone-x.xx.x-with-dependencies.jar'
              when 'Chrome'
                @preparations.push 'Android端末にChromeがインストールされているかご確認ください。'
                @preparations.push 'Android端末のChromeがv43以上かご確認ください。'
                @preparations.push '事前にAndroid端末でGoogleアカウント登録をしてください。'
                @preparations.push 'appiumをインストールしてください。'
                @runCommands.push
                  descriptions: [
                    '4.2以上のAndroidを操作するappiumサーバーを起動します。',
                  ]
                  command: 'appium --session-override &'
                @exitCommands.push 'killall -9 node'
              when 'Browser'
                @preparations.push 'Android端末にBrowser(com.android.browser)がインストールされているかご確認ください。'
                @preparations.push '事前にAndroid端末でGoogleアカウント登録をしてください。'
                @preparations.push 'appiumをインストールしてください。'
                @runCommands.push
                  descriptions: [
                    '4.2以上のAndroidを操作するappiumサーバーを起動します。',
                    'GUI(アプリケーション)版をお持ちの方はそちらでもappiumサーバーを起動できます。',
                  ]
                  command: 'appium --session-override &'
                @exitCommands.push 'killall -9 node'
          when 'chrome'
            @preparations.push 'chromedriverにパスを通してください。'
            @exitCommands.push "ps ax | grep chromedriver | awk '{print $1}' | xargs kill"
            if @config['allRangeScreenshot']
              switch @config['environment']
                when 'ruby'
                  @preparations.push 'imagemagickをインストールしてください。'
                  @preparations.push 'gemコマンドでrmagickをインストールしてください。'
                when 'python'
                  @preparations.push 'pipコマンドでpillowをインストールしてください。'

        switch @config['environment']
          when 'ruby'
            @preparations.push 'gemコマンドでselenium-webdriverをインストールしてください。'
            @runCommands.push
              descriptions: [
                '作成したファイルをrubyで実行します。',
                '保存したディレクトリに`cd`コマンドで移動して下記コマンドを実行します。',
                'stepsは適宜保存した名前で読み替えてください。',
              ]
              command: 'ruby steps.txt'
          when 'python'
            @preparations.push 'pipコマンドでseleniumをインストールしてください。'
            @runCommands.push
              descriptions: [
                '作成したファイルをpythonで実行します。',
                '保存したディレクトリに`cd`コマンドで移動して下記コマンドを実行します。',
                'stepsは適宜保存した名前で読み替えてください。',
              ]
              command: 'python steps.txt'

    return new HowToUse(config)
]