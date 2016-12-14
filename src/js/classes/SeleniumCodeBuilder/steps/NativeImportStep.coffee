class SeleniumCodeBuilder.Step.NativeImportStep extends SeleniumCodeBuilder.Step

  @Name: 'Import'
  @Tips:
    Description: '外部ファイルを呼び出す'
    Params:
      file:    '呼び出すファイル(拡張子なし)'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      file:  SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}require_relative '#{@params['file'].value}'
"""
      when "python"
        path_split = @params['file'].value.split('/')
        import_module = path_split.pop()
        add_path = path_split.join('/')
        add_path_code = if path_split.length > 0 then "'' if (Os.path.dirname(Os.path.abspath(__file__)) + '/#{add_path}') in Sys.path else Sys.path.append(Os.path.dirname(Os.path.abspath(__file__)) + '/#{add_path}')" else ''
        return """
#{tab}#{add_path_code}
#{tab}import #{import_module}
"""
