class SeleniumCodeBuilder.Step.ElementSendKeyCodesStep extends SeleniumCodeBuilder.Step

  @Name: 'Send Key Codes'
  @Tips:
    Description: 'キーを入力する'
    Params:
      location:   'CSSセレクタ'
      keys:       '入力するキー'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      location: SeleniumCodeBuilder.Input.text()
      keys:     SeleniumCodeBuilder.Input.array()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_wait.until { _driver.find_element(css: #{@params['location'].value}) }.send_keys(#{(@params['keys'].value.map (key)=> if key.length == 1 then "'#{key}'" else ":#{key.toLowerCase()}").join(', ')})
"""
      when "python"
        return """
#{tab}_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value})).send_keys(#{(@params['keys'].value.map (key)=> if key.length == 1 then "'#{key}'" else "Keys.#{key.toUpperCase()}").join(', ')})
"""
