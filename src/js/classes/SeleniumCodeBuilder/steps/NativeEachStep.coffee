class SeleniumCodeBuilder.Step.NativeEachStep extends SeleniumCodeBuilder.Step

  @Name: 'Each'
  @Tips:
    Description: '配列ループ'
    Params:
      variable: '変数名'
      key:      'キー名'
      value:    '値名'
      type:     '配列の種類'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      variable: SeleniumCodeBuilder.Input.text(null, isString = false)
      key:      SeleniumCodeBuilder.Input.text('index', isString = false)
      value:    SeleniumCodeBuilder.Input.text('value', isString = false)
      type:     SeleniumCodeBuilder.Input.select('array', ['array','hash'])
    @nodes = []

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        switch @params['type'].value
          when 'array'
            method = 'each_with_index'
            key = @params['value'].value
            value = @params['key'].value
          when 'hash'
            method = 'each'
            key = @params['key'].value
            value = @params['value'].value
        return """
#{tab}#{@params['variable'].value}.#{method} do |#{key}, #{value}|
#{innerCode}
#{tab}end
"""
      when "python"
        switch @params['type'].value
          when 'array'
            list = "enumerate(#{@params['variable'].value})"
          when 'hash'
            list = "#{@params['variable'].value}.iteritems()"
        return """
#{tab}for #{@params['key'].value}, #{@params['value'].value} in #{list}:
#{innerCode}
"""
