Game = React.createClass
  startCountdown: ->
    store.dispatch(type: 'startCountdown')

  render: ->
    div {},
      @renderCountdown()
      @renderTasks()
      "Target: " + @props.target
      ' '
      button type: "submit", className: "btn btn-primary", onClick: @startCountdown, 'Press when ready'

  renderCountdown: ->
    div {},
      if @props.countdown
        'countdown: ' + @props.countdown
      else if 0 == @props.countdown and not @props.tasks.length
        'READY!'


  renderTasks: ->
    ul {},
      _.map @props.tasks, (task) ->
        li {}, task.desc+" "+task.time
