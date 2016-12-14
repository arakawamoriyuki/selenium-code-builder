# SeleniumCodeBuilder

Seleniumを使ったブラウザテストのコードをGUIで組み立て、出力するChromeエクステンションです。
出力したテストコードは下記の言語とブラウザに対応しています。

言語

- Ruby
- Python

実行できるブラウザ

- Chrome
- Firefox
- Android Chrome
- Android Browser

公開されているエクステンションではないのでInstallationに従ってbuildし、インストールしてください。

## Installation

- git clone
- [nodejs](https://nodejs.org/ja/)を入れる
- buildツールgulpとフロントエンドライブラリ管理ツールbowerをinstall

```
$ npm install -g bower gulp
$ npm install
$ bower install
$ gulp build
```

- Chromeを開く
- メニュー
- 設定
- 拡張機能
- デベロッパーモードにチェック
- パッケージ化されていない拡張機能を読み込む
- selenium-code-builderフォルダを指定
- Chromeのツールバーから拡張を起動


## Environment

SeleniumCodeBuilderはあくまでコードを出力するツールで、実行までをサポートしている訳ではありません。
実行には下記環境が必要になります。

### Androidのブラウザを動かす場合

- java install
- JAVA_HOME環境変数設定
- Android SDK ManagerでToolsとAndroid 4.2 API Level 17以上をダウンロード
- ANDROID_HOME環境変数設定

- nodejs

appium(cui)のinstallに必要。
[こちら](https://nodejs.org/en/download/)からダウンロード。

- appium(cui)

Android4.2~でChromeやBrowserを動かすのに必要なツール。

```
$ npm install -g appium
$ npm install wd
```

Appiumが使用できる環境にあるか確認する

```
$ appium-doctor --android
```

- appium_lib

RubyでAppiumを利用してAndroidのブラウザを動かすのに必要

```
$ gem install appium_lib
```

- Appium-Python-Client

PythonでAppiumを利用してAndroidのブラウザを動かすのに必要

```
$ pip install Appium-Python-Client
```

- selendroid-standalone

古いAndroidv2.3~のブラウザを動かすのに必要なツール。
[こちら](http://selendroid.io/)のDownload Jarから.jarファイルをダウンロードしてください。
下記実行方法。

```
$ java -jar selendroid-standalone-0.17.0-with-dependencies.jar
```

### Chromeを動かす場合

- chromedriver
[こちら](http://chromedriver.storage.googleapis.com/index.html)からchromedriverをダウンロードしてパスを通してください。
2.9はmac,windows共に確認済み。2.15はmac確認済み。現時点最新の2.19 ~ 2.21は動きませんでした。

### Pythonで実行する場合

- python 2.x

- selenium
selenium本体。必須。
```
$ pip install selenium
```

- pillow
chromeで全体スクショを取る場合、出力の際に「all range screenshot」にチェックを入れます。実行の際にimport pillowするので必要。必要なければ飛ばしてOK。
```
$ pip install pillow
```

- requests
外部にリクエストを投げるNative.ApiRequestステップで必要。必要なければ飛ばしてOK。
```
$ pip install requests
```

### Rubyを使う場合

- ruby 2.x.x

- selenium-webdriver
selenium本体。必須。
```
$ gem install selenium-webdriver
```

- rmagick
chromeで全体スクショを取る場合、出力の際に「all range screenshot」にチェックを入れます。実行の際にrequire 'RMagick'するので必要。必要なければ飛ばしてOK。
```
$ gem install rmagick
```

- imagemagick
rmagickを使うなら依存しているので必要。必要なければ飛ばしてOK。
```
$ brew install imagemagick
```


## Usage

Menu -> How to useをご覧ください。

## Tips

- Androidのv4.2以上を動かす際はgoogleログインが必要です。(google playを開いてログイン画面が出なければログインされています)

## Development

## Contributing

## License

MIT