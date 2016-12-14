class SeleniumCodeBuilder.Step.NativeGetTimeStep extends SeleniumCodeBuilder.Step

  @Name: 'Get Time'
  @Tips:
    Description: '現在の時間を取得する'
    Params:
      variable:   '変数名'
      format:     'フォーマット'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      variable:   SeleniumCodeBuilder.Input.text(null, isString = false)
      format:     SeleniumCodeBuilder.Input.text('%Y%m%d%H%M%S')
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}#{@params['variable'].value} = Time.now.strftime(#{@params['format'].value})
"""
      when "python"
        return """
#{tab}#{@params['variable'].value} = Datetime.now().strftime(#{@params['format'].value})
"""
