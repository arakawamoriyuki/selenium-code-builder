class SeleniumCodeBuilder.Step.BrowserScreenshotStep extends SeleniumCodeBuilder.Step

  @Name: 'Screenshot'
  @Tips:
    Description: 'スクリーンショットを撮る'
    Params:
      path:      '実行場所からの保存パス'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      path:     SeleniumCodeBuilder.Input.text('./screenshot.png')
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.save_screenshot(#{@params['path'].value})
"""
      when "python"
        return """
#{tab}_driver.save_screenshot(#{@params['path'].value})
"""
