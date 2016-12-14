# 先頭大文字フィルタ
# {{'test'|capitalize}} = Test
window.app.filter 'capitalize', ->
  (input) ->
    if input? then input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() else ''
