# ng-repeatのオブジェクトループにフィルタをかける
# <div ng-repeat="param in params | objectSelect:'type':['array', 'hash']">
window.app.filter 'objectSelect', ->
  (objects, key, values) ->
    result = {}
    angular.forEach objects, (object, objectKey) =>
      if values.indexOf(object[key]) != -1
        result[objectKey] = object
    return result
