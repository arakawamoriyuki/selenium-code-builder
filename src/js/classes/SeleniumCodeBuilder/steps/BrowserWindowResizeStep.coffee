class SeleniumCodeBuilder.Step.BrowserWindowResizeStep extends SeleniumCodeBuilder.Step

  @Name: 'Window Resize'
  @Tips:
    Description: 'ブラウザのサイズを設定する'
    Params:
      width:  '幅'
      height: '高さ'
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params =
      width:  SeleniumCodeBuilder.Input.number(1200)
      height: SeleniumCodeBuilder.Input.number(800)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.manage.window.resize_to(#{@params['width'].value}, #{@params['height'].value})
"""
      when "python"
        return """
#{tab}_driver.set_window_size(#{@params['width'].value}, #{@params['height'].value})
"""
