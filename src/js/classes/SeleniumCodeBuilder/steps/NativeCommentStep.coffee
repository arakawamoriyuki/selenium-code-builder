class SeleniumCodeBuilder.Step.NativeCommentStep extends SeleniumCodeBuilder.Step

  @Name: 'Comment'
  @Tips:
    Description: 'コメントを残す'
    Params:
      comment:   'コメント内容'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      comment:   SeleniumCodeBuilder.Input.text('TODO:', isString = false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}# #{@params['comment'].value}
"""
      when "python"
        return """
#{tab}# #{@params['comment'].value}
"""
