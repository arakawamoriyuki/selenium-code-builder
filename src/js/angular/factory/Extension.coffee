# 単に拡張子変換用関数
window.app.factory 'Extension', [()->
  return (langage = 'ruby') =>
    extensions =
      ruby:'rb'
      python:'py'
    return extensions[langage.toLowerCase()]
]