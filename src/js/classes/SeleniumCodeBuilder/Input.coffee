class SeleniumCodeBuilder.Input

  # 文字列のパラメータ
  # @param value 初期値
  # @param isString 文字列として"で囲うかどうか。文字列の場合#{}で変数を展開する
  @text = (value = '', isString = true) =>
    type:'text'
    value:value
    isString:isString

  # 数値のパラメータ
  # @param value 初期値
  @number = (value = 0) =>
    type:'number'
    value:value

  # 選択式のパラメータ
  # @param value 初期値
  # @param item
  @select = (value = null, items) =>
    type:'select'
    value:value
    items:items

  # 選択式のパラメータ
  # @param value 初期値
  # @param items 選択肢
  @check = (value = false) =>
    type:'check'
    value:value

  # 配列のパラメータ
  # @param value 初期値
  @array = (value = []) =>
    type:'array'
    value:value

  # hashのパラメータ
  # @param value 初期値
  # # angularでkeyはbind出来ないので配列でhashを表現する
  # for v in value
  #   key = v[0]
  #   value = v[1]
  @hash = (value = []) =>
    type:'hash'
    value:value
