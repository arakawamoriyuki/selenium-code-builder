class SeleniumCodeBuilder.Step.NativePrintStep extends SeleniumCodeBuilder.Step

  @Name: 'Print'
  @Tips:
    Description: '値を表示する'
    Params:
      value:    '表示する値'
      string:   '表示する値が文字列か'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      value:    SeleniumCodeBuilder.Input.text()
      string:   SeleniumCodeBuilder.Input.check(true)
    @nodes = null

  to: (lang, innerCode, tab) ->
    # 文字列内変数エスケープ前の値を保持
    oldParams = angular.copy(@params)
    super(lang, innerCode, tab)
    # 文字でなければエスケープ前の値を使用
    @params['value'].value = oldParams['value'].value if not @params['string'].value
    switch lang
      when "ruby"
        return """
#{tab}puts #{@params['value'].value}.to_s
"""
      when "python"
        return """
#{tab}print #{@params['value'].value}
"""
