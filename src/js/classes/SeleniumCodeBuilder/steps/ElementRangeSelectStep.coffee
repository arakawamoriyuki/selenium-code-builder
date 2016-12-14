class SeleniumCodeBuilder.Step.ElementRangeSelectStep extends SeleniumCodeBuilder.Step

  @Name: 'Range Select'
  @Tips:
    Description: '要素のテキストを選択する'
    Params:
      location:   'CSSセレクタ(変数展開不可)'
      start:      '始端'
      end:        '終端(マイナス値で全て)'
  @Correspondence:
    firefox: true
    chrome: true
    android: true

  default: ()->
    @params =
      location:       SeleniumCodeBuilder.Input.text(null, isString = false)
      start:          SeleniumCodeBuilder.Input.number(0)
      end:            SeleniumCodeBuilder.Input.number(-1)
    @nodes = null

  to: (lang, innerCode, tab) ->
    super(lang, innerCode, tab)
    switch lang
      when "ruby"
        return """
#{tab}_driver.execute_script(<<-'EOS'
#{tab}  element = document.querySelector("#{@params['location'].value}");
#{tab}  range = document.createRange();
#{tab}  range.setStart(element.firstChild, #{@params['start'].value});
#{tab}  range.setEnd(element.firstChild, #{if @params['end'].value < 0 then 'element.firstChild.length' else @params['end'].value});
#{tab}  window.getSelection().removeAllRanges();
#{tab}  window.getSelection().addRange(range);
#{tab}EOS
#{tab})
"""
      when "python"
        return """
#{tab}_driver.execute_script(u\"""
#{tab}    element = document.querySelector("#{@params['location'].value}");
#{tab}    range = document.createRange();
#{tab}    range.setStart(element.firstChild, #{@params['start'].value});
#{tab}    range.setEnd(element.firstChild, #{if @params['end'].value < 0 then 'element.firstChild.length' else @params['end'].value});
#{tab}    window.getSelection().removeAllRanges();
#{tab}    window.getSelection().addRange(range);
#{tab}\""")
"""
