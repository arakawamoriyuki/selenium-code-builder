class SeleniumCodeBuilder.Step.ElementSendKeysStep extends SeleniumCodeBuilder.Step

  @Name: 'Send Keys'
  @Tips:
    Description: '入力フィールドに入力する'
    Params:
      location:     'CSSセレクタ'
      input:        '入力値'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      location:     SeleniumCodeBuilder.Input.text()
      input:        SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_wait.until { _driver.find_element(css: #{@params['location'].value}) }.send_keys(#{@params['input'].value})
"""
      when "python"
        return """
#{tab}_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value})).send_keys(#{@params['input'].value})
"""
