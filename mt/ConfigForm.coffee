ConfigForm = React.createClass
  startGame: (e) ->
    e.preventDefault()
    store.dispatch(type: 'startGame') unless @props.error

  render: ->
    div {},
      p className: "lead",
        'The game is not started yet. Select training time and press Start.'
      form className: "form-inline", onSubmit: @startGame,
        # div(className: "form-group",
        #   label({}, 'Time: '),
        #   select className: "form-control", defaultValue: @props.type, onChange: @changeType, style: {width: 'auto'},
        #     option(value: 'random',  'Random time'),
        #     option(value: 'minutes', 'Minutes'),
        #     option(value: 'seconds', 'Seconds'))

        br {}
        button type: "submit", className: "btn btn-primary btn-lg", disabled: @props.error, 'Start training'
