class SeleniumCodeBuilder.Step.ElementFileUploadStep extends SeleniumCodeBuilder.Step

  @Name: 'File Upload'
  @Tips:
    Description: 'ファイルを選択する'
    Params:
      location:   'CSSセレクタ'
      path:       '実行場所からのアップロードするファイルパス'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      location:   SeleniumCodeBuilder.Input.text()
      path:       SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_wait.until { _driver.find_element(css: #{@params['location'].value}) }.send_keys("\#{Dir.pwd}/"+#{@params['path'].value})
"""
      when "python"
        return """
#{tab}_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value})).send_keys(unicode(Os.path.abspath(Os.path.dirname(__file__))) + "/" + #{@params['path'].value})
"""
