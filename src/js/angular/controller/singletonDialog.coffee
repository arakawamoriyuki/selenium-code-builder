window.app.controller 'SingletonDialogController',
['$scope', '$mdDialog',
($scope, $mdDialog) =>

  $scope.close = $mdDialog.hide
]
