class SeleniumCodeBuilder.Step.ElementSelectStep extends SeleniumCodeBuilder.Step

  @Name: 'Select'
  @Tips:
    Description: 'セレクトボックスを選択する'
    Params:
      location:     'CSSセレクタ'
      value:        '選択値'
      by:           '選択値の種類'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      location:     SeleniumCodeBuilder.Input.text()
      value:        SeleniumCodeBuilder.Input.text()
      by:           SeleniumCodeBuilder.Input.select('text', ['text','value','index'])
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}Selenium::WebDriver::Support::Select.new(_wait.until { _driver.find_element(css: #{@params['location'].value}) }).select_by(:#{@params['by'].value},  #{@params['value'].value})
"""
      when "python"
        switch @params['by'].value
          when "text"
            selectBy = "visible_text"
          when "value"
            selectBy = "value"
          when "index"
            selectBy = "index"
        return """
#{tab}Select(_wait.until(lambda _driver: _driver.find_element(By.CSS_SELECTOR, #{@params['location'].value}))).select_by_#{selectBy}(#{@params['value'].value})
"""
