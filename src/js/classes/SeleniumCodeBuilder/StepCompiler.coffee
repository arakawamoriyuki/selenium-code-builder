class SeleniumCodeBuilder.StepCompiler
  constructor: (step) ->
    @action = step.action
    @params = step.params
    @nodes = step.nodes
    @step = new SeleniumCodeBuilder.Step[@action](step)

  isInnerCode: () ->
    @nodes?

  to: (langage = 'ruby', depth = 0, innerCode = '') ->
    softTabNum = {'ruby':2, 'python':4}
    softTab = ([1..softTabNum[langage]].map => ' ').join('')
    tab = if depth != 0 then (softTab for num in [1..depth]).join('') else ''
    if @step
      return @step.to(langage, innerCode, tab)
    else
      return "#{tab}# TODO: #{@action}"
