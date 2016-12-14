class SeleniumCodeBuilder.Step.NativeVariableStep extends SeleniumCodeBuilder.Step

  @Name: 'Variable'
  @Tips:
    Description: '変数を定義する'
    Params:
      variable:   '変数名'
      value:      '値'
      string:     '値が文字列かどうか'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
      value:      SeleniumCodeBuilder.Input.text()
      string:     SeleniumCodeBuilder.Input.check(true)
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
#{tab}#{@params['variable'].value} = #{@params['value'].value}
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = #{@params['value'].value}
"""
