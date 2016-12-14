class SeleniumCodeBuilder.Step.NavigationReloadStep extends SeleniumCodeBuilder.Step

  @Name: 'Reload'
  @Tips:
    Description: 'ページを更新する'
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
#{tab}_driver.navigate.refresh
"""
      when "python"
        return """
#{tab}_driver.refresh()
"""
