class SeleniumCodeBuilder.Step.NativeVariableArrayStep extends SeleniumCodeBuilder.Step

  @Name: 'Variable Array'
  @Tips:
    Description: '配列を定義する'
    Params:
      variable:   '変数名'
      string:     '値が文字列かどうか'
      values:     '値'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
      string:     SeleniumCodeBuilder.Input.check(true)
      values:     SeleniumCodeBuilder.Input.array()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        wrap = if @params['string'].value then '"' else ''
        return """
#{tab}#{@params['variable'].value} = [#{(@params['values'].value.map (value)=> "#{wrap}#{value}#{wrap}").join(',')}]
"""
      when "python"
        wrap = if @params['string'].value then '"' else ''
        unicode = if @params['string'].value then 'u' else ''
        return """
#{tab}#{@params['variable'].value} = [#{(@params['values'].value.map (value)=> "#{unicode}#{wrap}#{value}#{wrap}").join(',')}]
"""
