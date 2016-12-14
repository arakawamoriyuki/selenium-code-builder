class SeleniumCodeBuilder.Step.ElementCheckStep extends SeleniumCodeBuilder.Step

  @Name: 'Check'
  @Tips:
    Description: 'チェックボックス、ラジオボタンの操作'
    Params:
      location:   'CSSセレクタ'
      check:      'チェック状態'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      location:     SeleniumCodeBuilder.Input.text()
      check:        SeleniumCodeBuilder.Input.check(true)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}while (_wait.until { _driver.find_element(css: #{@params['location'].value}) }.attribute("checked") != nil) != #{@params['check'].value}
#{tab}  _wait.until { _driver.find_element(css: #{@params['location'].value}) }.click
#{tab}  sleep 1
#{tab}end
"""
      when "python"
        check = @params['check'].value.toString().charAt(0).toUpperCase() + @params['check'].value.toString().slice(1).toLowerCase()
        return """
#{tab}while (_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value}) ).get_attribute("checked") is not None) != #{check}:
#{tab}    _wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value}) ).click()
#{tab}    Time.sleep(1)
"""
