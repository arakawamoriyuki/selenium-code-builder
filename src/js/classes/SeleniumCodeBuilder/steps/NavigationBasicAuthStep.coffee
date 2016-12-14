class SeleniumCodeBuilder.Step.NavigationBasicAuthStep extends SeleniumCodeBuilder.Step

  @Name: 'Basic Auth'
  @Tips:
    Description: 'Basic認証の掛かったページを開く'
    Params:
      url:      'URL'
      username: 'ユーザー名'
      password: 'パスワード'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      url:      SeleniumCodeBuilder.Input.text()
      username: SeleniumCodeBuilder.Input.text()
      password: SeleniumCodeBuilder.Input.text()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}url_split = #{@params['url'].value}.split('://')
#{tab}_driver.navigate.to url_split[0] + '://' + #{@params['username'].value} + ':' + #{@params['password'].value} + '@' + url_split[1]
"""
      when "python"
        return """
#{tab}url_split = #{@params['url'].value}.split('://')
#{tab}_driver.get("{0}://{1}:{2}@{3}".format(url_split[0], #{@params['username'].value}, #{@params['password'].value}, url_split[1]))
"""
