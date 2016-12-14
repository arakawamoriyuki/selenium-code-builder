class SeleniumCodeBuilder.Step.BrowserAlertAcceptStep extends SeleniumCodeBuilder.Step

  @Name: 'Alert Accept'
  @Tips:
    Description: 'アラートのOKボタンを押す(alert, confirm, prompt)'
    Params: {}
  @Correspondence:
    firefox: true
    chrome: true
    android: false

  default: ()->
    @params = {}
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.switch_to.alert.accept
"""
      when "python"
        return """
#{tab}_driver.switch_to.alert.accept()
"""
