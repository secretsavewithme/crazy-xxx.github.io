NumberSelector = React.createClass
  label: ->
    @props.label || 'Value'

  render: ->
    div className: "form-group #{'has-error' if @props.hasError}",
      label {}, @label() + ': ',
      div className: 'input-group',
        input type: 'number', className: "form-control", value: @props.value, onChange: @props.onChange, step: 'any', min: @props.min, max: @props.max


MinMaxSelector = React.createClass
  handleChange: (fld, e) ->
    store.dispatch(type: 'changeVal', prop: fld, val: e.target.value)

  render: ->
    span {},
      el(NumberSelector, label: 'Min', value: @props.min, onChange: @handleChange.bind(@, 'min'), hasError: @props.error)
      el(NumberSelector, label: 'Max', value: @props.max, onChange: @handleChange.bind(@, 'max'), hasError: @props.error)


ConfigForm = React.createClass
  startGame: (e) ->
    e.preventDefault()
    store.dispatch(type: 'startGame') unless @props.error

  render: ->
    div {},
      p className: "lead",
        'The game is not started yet. Select training time and press Start.'
      form className: "form-inline", onSubmit: @startGame,
        el(NumberSelector,
          label: 'Number of pairs',
          value: @props.numberOfPairs,
          onChange: @numberOfPairsChanged,
          hasError: @props.error,
          min: 1,
          max: gxs.length)

        br {}
        button type: "submit", className: "btn btn-primary btn-lg", disabled: @props.error, 'Start training'

  numberOfPairsChanged: (e) ->
    store.dispatch(type: 'numberOfPairsChanged', value: e.target.value)
