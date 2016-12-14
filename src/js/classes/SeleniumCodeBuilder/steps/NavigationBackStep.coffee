class SeleniumCodeBuilder.Step.NavigationBackStep extends SeleniumCodeBuilder.Step

  # TODO: Chromeでdriver.back後にdriver.current_urlが動作しないバグがある

  @Name: 'Back'
  @Tips:
    Description: 'ページを戻る'
    Params: {}
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params = {}
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.navigate.back
"""
      when "python"
        return """
#{tab}_driver.back()
"""
