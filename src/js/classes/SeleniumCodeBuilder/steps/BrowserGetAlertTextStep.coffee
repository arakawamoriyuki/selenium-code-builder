class SeleniumCodeBuilder.Step.BrowserGetAlertTextStep extends SeleniumCodeBuilder.Step

  @Name: 'Get Alert Text'
  @Tips:
    Description: 'アラートの文字を取得する'
    Params:
      variable:   '変数名'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['variable'].value} = _driver.switch_to.alert.text
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = _driver.switch_to.alert.text
"""
