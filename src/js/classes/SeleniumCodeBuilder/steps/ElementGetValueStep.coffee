class SeleniumCodeBuilder.Step.ElementGetValueStep extends SeleniumCodeBuilder.Step

  @Name: 'Get Value'
  @Tips:
    Description: '入力フィールドから値を取得する'
    Params:
      location:   'CSSセレクタ'
      variable:   '変数名'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      location:   SeleniumCodeBuilder.Input.text()
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['variable'].value} = _wait.until { _driver.find_element(css: #{@params['location'].value}) }.attribute("value")
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = _wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value})).get_attribute("value")
"""
