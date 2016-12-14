class SeleniumCodeBuilder.Step.NativeExecuteStep extends SeleniumCodeBuilder.Step

  @Name: 'Execute'
  @Tips:
    Description: 'コードを実行する'
    Params:
      ruby:   '実行するrubyコード'
      python: '実行するpythonコード'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      ruby:   SeleniumCodeBuilder.Input.text(null, isString = false)
      python: SeleniumCodeBuilder.Input.text(null, isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    "#{tab}#{@params[lang].value}"
