class SeleniumCodeBuilder.Step.ElementGetCSSValueStep extends SeleniumCodeBuilder.Step

  @Name: 'Get CSS Value'
  @Tips:
    Description: 'CSSの値を取得する'
    Params:
      location:   'CSSセレクタ'
      variable:   '変数名'
      css:        '取得したいCSS値'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      location:   SeleniumCodeBuilder.Input.text()
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
      css:        SeleniumCodeBuilder.Input.text('display')
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['variable'].value} = _wait.until { _driver.find_element(css: #{@params['location'].value}) }.css_value(#{@params['css'].value})
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = _wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value})).value_of_css_property(#{@params['css'].value})
"""
