class SeleniumCodeBuilder.Step.ElementClearStep extends SeleniumCodeBuilder.Step

  @Name: 'Clear'
  @Tips:
    Description: '入力フィールドをクリアする'
    Params:
      location:   'CSSセレクタ'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      location:   SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_wait.until { _driver.find_element(css: #{@params['location'].value}) }.clear
"""
      when "python"
        return """
#{tab}_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value}) ).clear()
"""
