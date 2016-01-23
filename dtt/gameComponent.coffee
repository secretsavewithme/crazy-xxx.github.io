Game = React.createClass
  startCountdown: ->
    store.dispatch(type: 'startCountdown')

  render: ->
    div {},
      @renderCountdown() if @props.countdown
      @renderTasks()
      "Target: " + @props.target
      ' '
      button type: "submit", className: "btn btn-primary", onClick: @startCountdown, 'Press when ready'

  renderCountdown: ->
    div {},
      'countdown: ' + @props.countdown

  renderTasks: ->
    ul {},
      _.map @props.tasks, (task) ->
        li {}, task.desc
