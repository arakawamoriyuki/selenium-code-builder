# step-treeタグで展開するディレクティブ
# 組み上げたstepを一覧で表示する
window.app.directive 'stepTree', ['Step', 'StepService', (Step, StepService)->
  templateUrl: '/src/views/directive/stepTree.html'
  restrict: 'E'
  link: (scope, element, attrs) ->

    # angular-ui-treeのオプション。ドラッグ後、保存する
    scope.treeOptions =
      dragStop: (event) =>
        StepService.saveSteps()

    scope.Step = Step
    scope.StepService = StepService
]