{ button, div, form, h1, label, option, p, select, } = React.DOM

StartSelector = React.createClass
  getInitialState: ->
    value: 0

  handleSubmit: (e) ->
    e.preventDefault()
    @props.started(@state.value)

  handleChange: (e) ->
    @setState value: e.target.value

  render: ->
    div {},
      p className: "lead",
        'The game is not started. To start it select a value for A (target amount of money) and press Start.'
      form className: "form-inline", onSubmit: @handleSubmit,
        div(className: "form-group",
          label({}, 'A ='),
          select className: "form-control", onChange: @handleChange,
            option(value: 0, 'Random'),
            option(key: x, x) for x in [1..10]), ' '
        button type: "submit", className: "btn btn-primary", 'Start'

Game = React.createClass
  render: ->
    div {},
      "Target money: $#{@props.A * 100}"


OWRMain = React.createClass
  getInitialState: ->
    started: false

  startGame: (a) ->
    a ||= parseInt(1 + Math.random() * 10)
    @setState started: true, A: a

  render: ->
    div className: "container",
      h1({}, 'OWRMain'),
      if @state.started then <Game A={@state.A} /> else <StartSelector started={@startGame} />

ReactDOM.render <OWRMain />, document.getElementById('content')
