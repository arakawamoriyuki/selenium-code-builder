class SeleniumCodeBuilder.Step.NativeFunctionCallStep extends SeleniumCodeBuilder.Step

  @Name: 'Function Call'
  @Tips:
    Description: '関数を呼び出す'
    Params:
      function:   '呼び出す関数名'
      args:       '渡す引数(変数)'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      function:   SeleniumCodeBuilder.Input.text(null, isString = false)
      args:       SeleniumCodeBuilder.Input.array()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['function'].value}(#{['_driver', '_wait'].concat(@params['args'].value).join(', ')})
"""
      when "python"
        return """
#{tab}#{@params['function'].value}(#{['_driver', '_wait'].concat(@params['args'].value).join(', ')})
"""
