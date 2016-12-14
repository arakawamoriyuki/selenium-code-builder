class SeleniumCodeBuilder.Step.NavigationToStep extends SeleniumCodeBuilder.Step

  @Name: 'To'
  @Tips:
    Description: 'ページを開く'
    Params:
      url:      'URL'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      url:      SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.navigate.to #{@params['url'].value}
"""
      when "python"
        return """
#{tab}_driver.get(#{@params['url'].value})
"""
