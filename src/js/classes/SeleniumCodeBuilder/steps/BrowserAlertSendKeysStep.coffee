class SeleniumCodeBuilder.Step.BrowserAlertSendKeysStep extends SeleniumCodeBuilder.Step

  @Name: 'Alert Send Keys'
  @Tips:
    Description: 'アラートの入力フィールドに入力する(prompt)'
    Params:
      input:  '入力値'
  @Correspondence:
    firefox: true
    chrome: false
    android: false

  default: ()->
    @params =
      input:  SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.switch_to.alert.send_keys(#{@params['input'].value})
"""
      when "python"
        return """
#{tab}_driver.switch_to.alert.send_keys(#{@params['input'].value})
"""
