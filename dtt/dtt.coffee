{ a, button, div, form, img, h1, h2, h3, h4, input, label, li, option, p, select, span, strong, ul } = React.DOM
el = React.createElement

gameParamsInitialState =
  type: 'random'
  min: 5
  max: 10
  minutes: 3
  seconds: 300
  error: false

make = (prop, val) ->
  obj = {}
  obj[prop] = val
  obj

newState = (state, objs...) ->
  _.assign({}, state, objs...)

gameParamValid = (prop, val, state) ->
  return false unless _.isFinite(val) and +val > 0
  if prop == 'min'
    +val <= +state.max
  else if prop == 'max'
    +val >= +state.min
  else if prop == 'random'
    +state.min <= +state.max
  else
    true

gameParams = (state = gameParamsInitialState, action) ->
  switch action.type
    when 'changeType'
      newState(state, type: action.selected, error: not gameParamValid(action.selected, state[action.selected], state))
    when 'changeVal'
      newState(state, make(action.prop, action.val), error: not gameParamValid(action.prop, action.val, state))
    else
      state

calculateTargetTime = ->
  params = store.getState().gameParams
  switch params.type
    when 'random'
      _.random(params.min * 60, params.max * 60)
    when 'minutes'
      params.minutes * 60
    when 'seconds'
      params.seconds

gameInitialState =
  started: false

game = (state = gameInitialState, action) ->
  switch action.type
    when 'startGame'
      newState(state, started: true, target: calculateTargetTime())
    else
      state

trainerLogic = Redux.combineReducers({gameParams, game})

store = Redux.createStore(trainerLogic)


Game = React.createClass
  render: ->
    div {},
      "Target: " + @props.target



NumberSelector = React.createClass
  label: ->
    @props.label || 'Value'

  unit: ->
    if @props.type == 'seconds' then 's' else 'min'

  render: ->
    div(className: "form-group #{'has-error' if @props.hasError}",
      label({}, @label() + ': '),
      div className: 'input-group',
        input type: 'number', className: "form-control", value: @props.value, onChange: @props.onChange, step: 'any', min: 0
        div className: 'input-group-addon', @unit())

MinMaxSelector = React.createClass
  handleChange: (fld, e) ->
    store.dispatch(type: 'changeVal', prop: fld, val: e.target.value)

  render: ->
    span {},
      el(NumberSelector, label: 'Min', value: @props.min, onChange: @handleChange.bind(@, 'min'), hasError: @props.error)
      el(NumberSelector, label: 'Max', value: @props.max, onChange: @handleChange.bind(@, 'max'), hasError: @props.error)

StartSelector = React.createClass
  changeType: (e) ->
    store.dispatch(type: 'changeType', selected: e.target.value)

  handleChange: (e) ->
    store.dispatch(type: 'changeVal', prop: @props.type, val: e.target.value)

  startGame: (e) ->
    e.preventDefault()
    store.dispatch(type: 'startGame')

  render: ->
    div {},
      p className: "lead",
        'The game is not started yet. Select training time and press Start.'
      form className: "form-inline", onSubmit: @startGame,
        div(className: "form-group",
          label({}, 'Time: '),
          select className: "form-control", defaultValue: @props.type, onChange: @changeType, style: {width: 'auto'},
            option(value: 'random',  'Random time'),
            option(value: 'minutes', 'Minutes'),
            option(value: 'seconds', 'Seconds'))

        if 'random' == @props.type
          el(MinMaxSelector, @props)
        else
          el(NumberSelector, type: @props.type, value: @props[@props.type], onChange: @handleChange, hasError: @props.error)

        button type: "submit", className: "btn btn-primary", 'Start'


DTTMain = React.createClass
  render: ->
    div className: "container",
      h1({}, 'DT Trainer'),
      if @props.game.started
        el(Game, @props.game)
      else
        el(StartSelector, @props.gameParams)

render = ->
  ReactDOM.render(
    el(DTTMain, store.getState()),
    document.getElementById('content'))

store.subscribe(render)
render()

store.subscribe(-> console.log 'current state', store.getState())
