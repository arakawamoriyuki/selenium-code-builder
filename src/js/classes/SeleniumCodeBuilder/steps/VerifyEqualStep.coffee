class SeleniumCodeBuilder.Step.VerifyEqualStep extends SeleniumCodeBuilder.Step

  @Name: 'Equal'
  @Tips:
    Description: '値を検証する'
    Params:
      title:    '検証名'
      variable: '比較する変数'
      operator: '比較式'
      value:    '比較する値(null判定の場合無効)'
      string:   '比較する値が文字か(null判定の場合無効)'
      break:    '検証が失敗したら処理を止めるか'
  @Correspondence:
    firefox: true
    chrome: true
    android: true
    
  default: ()->
    @params =
      title:    SeleniumCodeBuilder.Input.text()
      variable: SeleniumCodeBuilder.Input.text(null, isString = false)
      operator: SeleniumCodeBuilder.Input.select('==', ['==', '!=', '>=', '>', '<=', '<', 'null', '!null'])
      value:    SeleniumCodeBuilder.Input.text()
      string:   SeleniumCodeBuilder.Input.check(true)
      break:    SeleniumCodeBuilder.Input.check(false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    # 文字列内変数エスケープ前の値を保持
    oldParams = angular.copy(@params)
    super(lang, innerCode, tab)
    # 文字でなければエスケープ前の値を使用
    @params['value'].value = oldParams['value'].value if not @params['string'].value
    switch lang
      when "ruby"
        check = "#{@params['variable'].value} #{@params['operator'].value} #{@params['value'].value}"
        if @params['operator'].value == 'null'
          check = "#{@params['variable'].value} == nil"
        else if @params['operator'].value == '!null'
          check = "#{@params['variable'].value} != nil"
        return """
#{tab}puts #{@params['title'].value}
if #{check}
#{tab}  puts "  #{@green('Test Passed', lang)}"
#{tab}else
#{tab}  puts "  #{@red('Test Failed!', lang)}"
#{tab}  #{if @params['break'].value then 'exit' else ''}
#{tab}end
"""
      when "python"
        check = "#{@params['variable'].value} #{@params['operator'].value} #{@params['value'].value}"
        if @params['operator'].value == 'null'
          check = "#{@params['variable'].value} is None"
        else if @params['operator'].value == '!null'
          check = "#{@params['variable'].value} is not None"
        return """
#{tab}print #{@params['title'].value}
#{tab}if #{check}:
#{tab}    print "  #{@green('Test Passed', lang)}"
#{tab}else:
#{tab}    print "  #{@red('Test Failed!', lang)}"
#{tab}    #{if @params['break'].value then 'exit()' else ''}
"""
