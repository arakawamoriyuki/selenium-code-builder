class SeleniumCodeBuilder.Step.NativeVariableHashStep extends SeleniumCodeBuilder.Step

  @Name: 'Variable Hash'
  @Tips:
    Description: '連想配列を定義する'
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
      values:     SeleniumCodeBuilder.Input.hash()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        wrap = if @params['string'].value then "'" else ""
        return """
#{tab}#{@params['variable'].value} = {#{(@params['values'].value.map (value) => "'#{value[0]}'=>#{wrap}#{value[1]}#{wrap}").join(',')}}
"""
      when "python"
        wrap = if @params['string'].value then "'" else ""
        unicode = if @params['string'].value then 'u' else ''
        return """
#{tab}#{@params['variable'].value} = {#{(@params['values'].value.map (value) => "u'#{value[0]}':#{unicode}#{wrap}#{value[1]}#{wrap}").join(',')}}
"""
