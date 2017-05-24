# step-menuタグで展開するディレクティブ
# 追加できるstep一覧をメニュー化する
window.app.directive 'stepMenu', ['Step', 'StepService', (Step, StepService)->
  templateUrl: '/src/views/directive/stepMenu.html'
  restrict: 'E'
  link: (scope, element, attrs) ->

    scope.addStepClass = StepService.addStepClass

    # メニュー
    scope.menus = [
      {category:'Navigation', steps:[
        Step.NavigationToStep,
        Step.NavigationBasicAuthStep,
        Step.NavigationBackStep,
        Step.NavigationForwardStep,
        Step.NavigationReloadStep,
        Step.NavigationGetUrlStep,
      ]},
      {category:'Element', steps:[
        Step.ElementClickStep,
        Step.ElementDoubleClickStep,
        Step.ElementClearStep,
        Step.ElementSendKeysStep,
        Step.ElementSendKeyCodesStep,
        Step.ElementSelectStep,
        Step.ElementCheckStep,
        Step.ElementFileUploadStep,
        Step.ElementDragAndDropStep,
        Step.ElementHoverStep,
        Step.ElementRangeSelectStep,
        Step.ElementGetElementStep,
        Step.ElementGetElementsStep,
        Step.ElementGetTextStep,
        Step.ElementGetValueStep,
        Step.ElementGetCSSValueStep,
      ]},
      {category:'Browser', steps:[
        Step.BrowserExecuteJavaScriptStep,
        Step.BrowserScreenshotStep,
        Step.BrowserScrollStep,
        Step.BrowserWindowResizeStep,
        Step.BrowserGetJSONStep,
        Step.BrowserAlertAcceptStep,
        Step.BrowserAlertDismissStep,
        Step.BrowserAlertSendKeysStep,
        Step.BrowserGetAlertTextStep,
      ]},
      {category:'Native', steps:[
        Step.NativeExecuteStep,
        Step.NativeSleepStep,
        Step.NativeVariableStep,
        Step.NativeVariableArrayStep,
        Step.NativeVariableHashStep,
        Step.NativeCalculateStep,
        Step.NativeIfStep,
        Step.NativeEachStep,
        Step.NativeWhileStep,
        Step.NativeTimesStep,
        Step.NativePrintStep,
        Step.NativeGetTimeStep,
        Step.NativeImportStep,
        Step.NativeFunctionStep,
        Step.NativeFunctionCallStep,
        Step.NativeApiRequestStep,
        Step.NativeCommentStep,
      ]},
      {category:'Verify', steps:[
        Step.VerifyEqualStep,
        Step.VerifyRegExpMatchStep,
        Step.VerifyFindTextStep,
      ]},
    ]
]