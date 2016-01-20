{ a, button, div, form, img, h1, h2, h3, h4, input, label, li, option, p, select, span, strong, ul } = React.DOM
el = React.createElement

gameParamsInitialState =
  type: 'minutes'
  min: 5
  max: 10
  minutes: 3
  seconds: 300

gameParams = (state = gameParamsInitialState, action) ->
  switch action.type
    when 'changeType'
      _.assign({}, state, type: action.selected)
    else
      state

trainerLogic = Redux.combineReducers({gameParams})

store = Redux.createStore(trainerLogic)

NumberSelector = React.createClass
  label: ->
    @props.label || 'Value'

  unit: ->
    if @props.type == 'seconds' then 's' else 'min'

  render: ->
    div(className: "form-group",
      label({}, @label() + ': '),
      div className: 'input-group',
        input type: 'number', className: "form-control", value: @props.value
        div className: 'input-group-addon', @unit())

MinMaxSelector = React.createClass
  render: ->
    span {},
      el(NumberSelector, type: 'Min', value: @props.min)
      el(NumberSelector, type: 'Max', value: @props.max)

StartSelector = React.createClass
  changeType: (e) ->
    store.dispatch(type: 'changeType', selected: e.target.value)

  render: ->
    div {},
      p className: "lead",
        'The game is not started yet. Select training time and press Start.'
      form className: "form-inline", onSubmit: @handleSubmit,
        div(className: "form-group",
          label({}, 'Time: '),
          select className: "form-control", defaultValue: @props.type, onChange: @changeType, style: {width: 'auto'},
            option(value: 'random',  'Random time'),
            option(value: 'minutes', 'Minutes'),
            option(value: 'seconds', 'Seconds'))

        if 'random' == @props.type
          el(MinMaxSelector, @props)
        else
          el(NumberSelector, type: @props.type, value: @props[@props.type])

        button type: "submit", className: "btn btn-primary", 'Start'


DTTMain = React.createClass
  render: ->
    div className: "container",
      h1({}, 'DT Trainer'),
      if @props.started
        el(Game)
      else
        el(StartSelector, @props.gameParams)

render = ->
  ReactDOM.render(
    el(DTTMain, store.getState()),
    document.getElementById('content'))

store.subscribe(render)
render()

store.subscribe(-> console.log 'current state', store.getState())
