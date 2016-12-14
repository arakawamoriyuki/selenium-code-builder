class SeleniumCodeBuilder.Step.NativeCalculateStep extends SeleniumCodeBuilder.Step

  @Name: 'Calculate'
  @Tips:
    Description: '計算を行う'
    Params:
      value1:   '値1(変数名または数値)'
      operator: '式'
      value2:   '値1(変数名または数値)'
      result:   '結果を保存する変数名'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      value1:   SeleniumCodeBuilder.Input.text(null, isString = false)
      operator: SeleniumCodeBuilder.Input.select('+', ['+', '-', '*', '/', '%'])
      value2:   SeleniumCodeBuilder.Input.text(null, isString = false)
      result:   SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['result'].value} = #{@params['value1'].value} #{@params['operator'].value} #{@params['value2'].value}
"""
      when "python"
        return """
#{tab}#{@params['result'].value} = #{@params['value1'].value} #{@params['operator'].value} #{@params['value2'].value}
"""
