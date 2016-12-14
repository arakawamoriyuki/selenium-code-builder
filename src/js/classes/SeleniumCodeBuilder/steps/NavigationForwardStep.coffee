class SeleniumCodeBuilder.Step.NavigationForwardStep extends SeleniumCodeBuilder.Step

  @Name: 'Forward'
  @Tips:
    Description: 'ページを進む'
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
#{tab}_driver.navigate.forward
"""
      when "python"
        return """
#{tab}_driver.forward()
"""
