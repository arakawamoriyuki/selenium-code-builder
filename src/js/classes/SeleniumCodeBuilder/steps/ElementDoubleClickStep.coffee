class SeleniumCodeBuilder.Step.ElementDoubleClickStep extends SeleniumCodeBuilder.Step

  @Name: 'Double Click'
  @Tips:
    Description: '指定箇所をダブルクリックする'
    Params:
      location:   'CSSセレクタ'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      location:      SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.action.double_click(_wait.until { _driver.find_element(css: #{@params['location'].value}) }).perform
"""
      when "python"
        return """
#{tab}ActionChains(_driver).double_click(_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value}))).perform()
"""
