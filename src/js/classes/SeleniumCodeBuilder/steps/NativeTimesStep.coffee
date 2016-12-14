class SeleniumCodeBuilder.Step.NativeTimesStep extends SeleniumCodeBuilder.Step

  @Name: 'Times'
  @Tips:
    Description: '指定回数ループ'
    Params:
      times:    '実行回数'
      index:    '現在の回数の変数名'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      times:    SeleniumCodeBuilder.Input.text(null, isString = false)
      index:    SeleniumCodeBuilder.Input.text('index', isString = false)
    @nodes = []

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['times'].value}.times do |#{@params['index'].value}|
#{innerCode}
#{tab}end
"""
      when "python"
        return """
#{tab}for #{@params['index'].value} in xrange(#{@params['times'].value}):
#{innerCode}
"""
