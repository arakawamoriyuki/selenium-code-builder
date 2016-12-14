class SeleniumCodeBuilder.Step.BrowserScrollStep extends SeleniumCodeBuilder.Step

  @Name: 'Scroll'
  @Tips:
    Description: '指定位置までスクロールする'
    Params:
      x:  '横'
      y:  '縦'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      x:  SeleniumCodeBuilder.Input.number(0)
      y:  SeleniumCodeBuilder.Input.number(500)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.execute_script("scroll(#{@params['x'].value}, #{@params['y'].value});")
"""
      when "python"
        return """
#{tab}_driver.execute_script("scroll(#{@params['x'].value}, #{@params['y'].value});")
"""
