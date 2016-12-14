class SeleniumCodeBuilder.Step.VerifyRegExpMatchStep extends SeleniumCodeBuilder.Step

  @Name: 'RegExp Match'
  @Tips:
    Description: '値を正規表現にマッチするか検証する'
    Params:
      title:    '検証名'
      variable: '検証する変数名'
      regexp:   '正規表現(デリミタ必要なし)'
      break:    '検証が失敗したら処理を止めるか'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      title:    SeleniumCodeBuilder.Input.text()
      variable: SeleniumCodeBuilder.Input.text(null, isString = false)
      regexp:   SeleniumCodeBuilder.Input.text(null, isString = false)
      break:    SeleniumCodeBuilder.Input.check(false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}puts #{@params['title'].value}
#{tab}if /#{@params['regexp'].value}/.match(#{@params['variable'].value})
#{tab}  puts "  #{@green('Test Passed', lang)}"
#{tab}else
#{tab}  puts "  #{@red('Test Failed!', lang)}"
#{tab}  #{if @params['break'].value then 'exit' else ''}
#{tab}end
"""
      when "python"
        return """
#{tab}print #{@params['title'].value}
#{tab}if Re.search(u"#{@params['regexp'].value}", unicode(#{@params['variable'].value})):
#{tab}    print "  #{@green('Test Passed', lang)}"
#{tab}else:
#{tab}    print "  #{@red('Test Failed!', lang)}"
#{tab}    #{if @params['break'].value then 'exit()' else ''}
"""
