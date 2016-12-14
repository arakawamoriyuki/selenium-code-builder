# ng-repeatのオブジェクトループにソートをかける
# <div ng-repeat="value in object | orderObjectBy:'index'">
# <div ng-repeat="value in object | orderObjectBy:'index'" ng-init="key = value['__key']">

window.app.filter 'orderObjectBy', ->
  (input, attribute, direction) ->
    if !angular.isObject(input)
      return input
    array = []
    for objectKey of input
      input[objectKey]['__key'] = objectKey
      array.push input[objectKey]
    array.sort (a, b) ->
      a = parseInt(a[attribute])
      b = parseInt(b[attribute])
      return a - b
      # return if (direction == 'asc') then a - b else b - a
    array
