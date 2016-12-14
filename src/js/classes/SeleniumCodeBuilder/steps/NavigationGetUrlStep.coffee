class SeleniumCodeBuilder.Step.NavigationGetUrlStep extends SeleniumCodeBuilder.Step

  # TODO: Chromeでdriver.back後にdriver.current_urlが動作しないバグがある

  @Name: 'Get Url'
  @Tips:
    Description: 'URLを取得する'
    Params:
      variable:   '変数名'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['variable'].value} = _driver.current_url
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = _driver.current_url
"""
