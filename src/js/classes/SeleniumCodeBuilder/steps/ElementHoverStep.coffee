class SeleniumCodeBuilder.Step.ElementHoverStep extends SeleniumCodeBuilder.Step

  @Name: 'Hover'
  @Tips:
    Description: '要素にマウスを移動する'
    Params:
      location:   'CSSセレクタ'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      location:   SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.action.move_to(_wait.until { _driver.find_element(css: #{@params['location'].value}) }).perform
"""
      when "python"
        return """
#{tab}ActionChains(_driver).move_to_element(_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value}))).perform()
"""
