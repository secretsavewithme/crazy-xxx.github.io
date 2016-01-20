{ a, button, div, form, img, h1, h2, h3, h4, input, label, li, option, p, select, span, strong, ul } = React.DOM
el = React.createElement

initialState =
  gameParams:
    type: 'random'
    min: 5
    max: 10
    mins: 5
    secs: 300

trainerLogic = (state = initialState, action) ->
  state

store = Redux.createStore(trainerLogic)

StartSelector = React.createClass
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
        ' '
        div(className: "form-group",
          label({}, 'Min: '),
          div className: 'input-group',
            input type: 'number', className: "form-control"
            div className: 'input-group-addon', 'min')
        ' '
        div(className: "form-group",
          label({}, 'Max: '),
          div className: 'input-group',
            input type: 'number', className: "form-control"
            div className: 'input-group-addon', 'min')
        ' '
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
