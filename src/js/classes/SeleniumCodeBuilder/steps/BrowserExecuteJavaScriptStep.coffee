class SeleniumCodeBuilder.Step.BrowserExecuteJavaScriptStep extends SeleniumCodeBuilder.Step

  @Name: 'Execute JavaScript'
  @Tips:
    Description: 'JavaScriptを実行する'
    Params:
      variable:   '戻り値を保存する変数名(オプション)'
      script:     '実行するJavaScript'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
      script:     SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        assignment = if @params['variable'].value then "#{@params['variable'].value} = " else ''
        return """
#{tab}#{assignment}_driver.execute_script(#{@params['script'].value})
"""
      when "python"
        assignment = if @params['variable'].value then "#{@params['variable'].value} = " else ''
        return """
#{tab}#{assignment}_driver.execute_script(#{@params['script'].value})
"""
