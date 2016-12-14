class SeleniumCodeBuilder.Step.NativeSleepStep extends SeleniumCodeBuilder.Step

  @Name: 'Sleep'
  @Tips:
    Description: '指定秒数待機する'
    Params:
      value:    '待機する秒数'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      value:  SeleniumCodeBuilder.Input.number(1)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}sleep #{@params['value'].value}
"""
      when "python"
        return """
#{tab}Time.sleep(#{@params['value'].value})
"""
