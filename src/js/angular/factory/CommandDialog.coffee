# 出力時に実行方法の案内を表示する
window.app.factory 'CommandDialog', ['$mdDialog', 'HowToUse', ($mdDialog, HowToUse)->
  return (config) =>
    howtouse = HowToUse(config)
    $mdDialog.show(
      templateUrl:'dialog/command.html'
      controller: ['$scope', ($scope)->
        $scope.close = $mdDialog.hide
        $scope.preparations = howtouse.preparations
        $scope.runCommands = howtouse.runCommands
        $scope.exitCommands = howtouse.exitCommands
      ]
    )
]