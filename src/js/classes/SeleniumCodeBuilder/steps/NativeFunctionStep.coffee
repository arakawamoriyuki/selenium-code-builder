class SeleniumCodeBuilder.Step.NativeFunctionStep extends SeleniumCodeBuilder.Step

  @Name: 'Function'
  @Tips:
    Description: '関数を定義する'
    Params:
      function:   '定義する関数名'
      args:       '受け取る引数'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      function:   SeleniumCodeBuilder.Input.text(null, isString = false)
      args:       SeleniumCodeBuilder.Input.array()
    @nodes = []

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}def #{@params['function'].value}(#{['_driver', '_wait'].concat(@params['args'].value).join(', ')})
#{innerCode}
#{tab}end
"""
      when "python"
        return """
#{tab}def #{@params['function'].value}(#{['_driver', '_wait'].concat(@params['args'].value).join(', ')}):
#{innerCode}
"""
