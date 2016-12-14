class SeleniumCodeBuilder.Step.VerifyFindTextStep extends SeleniumCodeBuilder.Step

  @Name: 'Find Text'
  @Tips:
    Description: 'ページ内に指定の文字があるか検証する'
    Params:
      title:    '検証名'
      text:     '検索する値'
      string:   '検索する値が文字列かどうか'
      break:    '検証が失敗したら処理を止めるか'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      title:    SeleniumCodeBuilder.Input.text()
      text:     SeleniumCodeBuilder.Input.text()
      string:   SeleniumCodeBuilder.Input.check(true)
      break:    SeleniumCodeBuilder.Input.check(false)
    @nodes = null

  to: (lang, innerCode, tab) ->
    # 文字列内変数エスケープ前の値を保持
    oldParams = angular.copy(@params)
    super(lang, innerCode, tab)
    # 文字でなければエスケープ前の値を使用
    @params['text'].value = oldParams['text'].value if not @params['string'].value
    switch lang
      when "ruby"
        return """
#{tab}puts #{@params['title'].value}
#{tab}begin
#{tab}  searchText = #{@params['text'].value}
#{tab}  _wait.until { /\#{searchText}/.match(_driver.page_source) }
#{tab}  puts "  #{@green('Test Passed', lang)}"
#{tab}rescue => e
#{tab}  puts "  #{@red('Test failed!', lang)}"
#{tab}  puts "    #{@red("`#{oldParams['text'].value}` text was not found in the page.", lang)}"
#{tab}  #{if @params['break'].value then 'exit' else ''}
#{tab}end
"""
      when "python"
        return """
#{tab}print #{@params['title'].value}
#{tab}try:
#{tab}    searchText = #{@params['text'].value}
#{tab}    _wait.until(lambda _driver: Re.search(searchText, _driver.page_source))
#{tab}    print "  #{@green('Test Passed', lang)}"
#{tab}except:
#{tab}    print "  #{@red('Test failed!', lang)}"
#{tab}    print "    #{@red("`#{oldParams['text'].value}` text was not found in the page.", lang)}"
#{tab}    #{if @params['break'].value then 'exit()' else ''}
"""
