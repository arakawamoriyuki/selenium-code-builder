# コード変換ダイアログの表示
window.app.factory 'ConvertDialog', ['$mdDialog', 'Step',(@$mdDialog, @Step)->
  return (steps) =>

    @$mdDialog.show(
      templateUrl:'dialog/convert.html'
      controller: ['$scope', '$mdDialog', ($scope, $mdDialog) =>

        # 対応状況を精査し、非対応文言配列を返す
        $scope.getCompatibles = (platformName) =>
          _compatibles = []
          for stepClass in $scope.stepClasses
            if stepClass.Correspondence[platformName.toLowerCase()] is false
              _compatibles.push "#{platformName}は#{stepClass.Name}に対応していません。"
          return _compatibles

        $scope.steps = steps
        $scope.stepClasses = (@Step.getClass(step.action) for step in $scope.steps)

        $scope.config = {
          environment: 'ruby'
          platformName: 'chrome'
          waitTimeout: 10
        }

        # 非対応文言配列
        $scope.compatibles = $scope.getCompatibles($scope.config.platformName)

        # androidで使用できるブラウザ
        $scope.browserNames = ['Chrome', 'Browser', 'Selendroid(standalone)']
        $scope.automationNames = ['Appium', 'Selendroid', 'Selendroid(standalone)']

        $scope.close = $mdDialog.hide

        $scope.onPlatformNameChange = (platformName) =>
          $scope.compatibles = $scope.getCompatibles(platformName)

        $scope.onVersionChange = (version) =>
          if version?
            match = version.match(/^([\d])\.([\d])$/)
            major = parseInt(match[1])
            minor = parseInt(match[2])

            # 4.4以上
            if 4 < major or (4 == major and 4 <= minor)
              $scope.browserNames = ['Chrome', 'Browser', 'Selendroid(standalone)']
              $scope.config.browserName = 'Chrome'
              $scope.automationNames = ['Appium', 'Selendroid(standalone)']
              $scope.config.automationName = 'Appium'
            # 4.2 ~ 4.3
            else if 4 < major or (4 == major and 2 <= minor)
              $scope.browserNames = ['Chrome', 'Selendroid(standalone)']
              $scope.config.browserName = 'Chrome'
              $scope.automationNames = ['Selendroid', 'Selendroid(standalone)']
              $scope.config.automationName = 'Selendroid'
            # 4.1以下
            else
              $scope.browserNames = ['Selendroid(standalone)']
              $scope.config.browserName = 'Selendroid(standalone)'
              $scope.automationNames = ['Selendroid(standalone)']
              $scope.config.automationName = 'Selendroid(standalone)'

        $scope.onAutomationNameChange = (automationName) =>
          if automationName?
            if automationName is 'Selendroid(standalone)'
              $scope.config.browserName = 'Selendroid(standalone)'
            else
              $scope.config.browserName = ($scope.browserNames.filter (browserName) => browserName isnt 'Selendroid(standalone)')[0]

        $scope.onBrowserNameChange = (browserName) =>
          if browserName?
            if browserName is 'Selendroid(standalone)'
              $scope.config.automationName = 'Selendroid(standalone)'
            else
              $scope.config.automationName = ($scope.automationNames.filter (automationName) => automationName isnt 'Selendroid(standalone)')[0]

      ]
    )
]
