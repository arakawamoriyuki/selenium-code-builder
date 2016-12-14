class SeleniumCodeBuilder.Step.BrowserGetJSONStep extends SeleniumCodeBuilder.Step

  @Name: 'Get JSON'
  @Tips:
    Description:  '現在のページに表示されたJSONデータを取得する'
    Params:
      variable:   '変数名'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      variable: SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['variable'].value} = JSON.parse(_driver.page_source[/([{\\[].*[}\\]])/, 1])
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = Json.loads(Re.search(r"([{\\[].*[}\\]])", _driver.page_source).group())
"""
