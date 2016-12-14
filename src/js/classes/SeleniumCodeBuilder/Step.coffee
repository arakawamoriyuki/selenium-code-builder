class SeleniumCodeBuilder.Step

  @Name: 'TODO'
  @Tips:
    Description: 'TODO'
    Params: {}

  @getClass: (action) =>
    @[action]

  constructor: (step = null) ->
    if step
      @action = step.action
      @params = step.params
      @nodes = step.nodes
    else
      @action = @constructor.name
      this.default()
    index = 0
    for key, param of @params
      param.index = index
      index++

  to: (lang, innerCode, tab) ->
    @stringParamsVariableExpansion(lang)

  # input.text系の変数展開 #{}で展開できるようにする
  stringParamsVariableExpansion: (lang) ->
    switch lang
      when "ruby"
        for key, param of @params
          if param.type == 'text' && param.isString
            param.value = '"' + param.value + '"'
      when "python"
        for key, param of @params
          if param.type == 'text' && param.isString
            param.value = 'u"' + param.value + '"'
            # #{変数名}が含まれていれば
            if /\#{(.+?)}/g.test(param.value)
              # python用変数エスケープ構文{}に修正
              param.value = param.value.replace(/\#{(.+?)}/g, "{$1}")
              # 定義されている変数を使用してフォーマット
              param.value = param.value + '.format(**(lambda d, g, v: (d.update(g) or d.update(v)) or d )(dict(), globals(), vars()))'

  default: ()->
    @params = {}
    @nodes = null

  color: (text, color, langage = 'ruby') ->
    switch langage
      when 'ruby'
        return "\\e[#{color}m#{text}\\e[0m"
      when 'python'
        return "\\033[#{color}m#{text}\\033[0m"

  red: (text, langage = 'ruby') ->
    @color(text, 31, langage)

  green: (text, langage = 'ruby') ->
    @color(text, 32, langage)

  yellow: (text, langage = 'ruby') ->
    @color(text, 33, langage)

  blue: (text, langage = 'ruby') ->
    @color(text, 34, langage)
