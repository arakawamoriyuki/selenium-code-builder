class SeleniumCodeBuilder.Step.BrowserAlertDismissStep extends SeleniumCodeBuilder.Step

  @Name: 'Alert Dismiss'
  @Tips:
    Description: 'アラートのCancelボタンを押す(confirm, prompt)'
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
#{tab}_driver.switch_to.alert.dismiss
"""
      when "python"
        return """
#{tab}_driver.switch_to.alert.dismiss()
"""
