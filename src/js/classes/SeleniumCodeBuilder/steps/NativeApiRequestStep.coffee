class SeleniumCodeBuilder.Step.NativeApiRequestStep extends SeleniumCodeBuilder.Step

  @Name: 'Api Request'
  @Tips:
    Description: 'APIへリクエストを送る'
    Params:
      variable: '戻り値を保存する変数名(オプション)'
      url:      'APIのURL'
      method:   'HTTPメソッド'
      params:   '送るパラメータ'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      variable: SeleniumCodeBuilder.Input.text(null, isString = false)
      url:      SeleniumCodeBuilder.Input.text()
      method:   SeleniumCodeBuilder.Input.select('GET', ['GET', 'POST'])
      params:   SeleniumCodeBuilder.Input.hash()
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    assignment = if @params['variable'].value then "#{@params['variable'].value} = " else ''
    switch lang
      when "ruby"
        switch @params['method'].value
          when 'GET'
            request = """
#{tab}_uri.query = URI.encode_www_form({#{(@params['params'].value.map (value) => "\"#{value[0]}\"=>\"#{value[1]}\"").join(' ,')}})
#{tab}_request = Net::HTTP::Get.new _uri
"""
          when 'POST'
            request = """
#{tab}_request = Net::HTTP::Post.new _uri.path
#{tab}_request.set_form_data({#{(@params['params'].value.map (value) => "\"#{value[0]}\"=>\"#{value[1]}\"").join(' ,')}})
"""
        return """
#{tab}_uri = URI.parse(#{@params['url'].value})
#{tab}_http = Net::HTTP.new(_uri.host, _uri.port)
#{tab}_http.use_ssl = (_uri.scheme == 'https')
#{tab}_http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#{tab}#{request}
#{tab}#{assignment}JSON.parse(_http.request(_request).body)
"""
      when "python"
        return """
import requests as Requests
#{tab}#{assignment}Requests.get(#{@params['url'].value}, params = {#{(@params['params'].value.map (value) => "\"#{value[0]}\":\"#{value[1]}\"").join(' ,')}}, verify = False).json()
"""
