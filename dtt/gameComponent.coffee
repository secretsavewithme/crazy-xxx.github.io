Game = React.createClass
  startCountdown: ->
    store.dispatch(type: 'startCountdown')

  render: ->
    div {},
      @renderCountdown() if @props.countdown
      "Target: " + @props.target
      ' '
      button type: "submit", className: "btn btn-primary", onClick: @startCountdown, 'Press when ready'

  renderCountdown: ->
    div {},
      'countdown: ' + @props.countdown
