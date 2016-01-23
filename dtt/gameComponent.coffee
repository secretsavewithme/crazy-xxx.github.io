Game = React.createClass
  componentWillMount: ->
    console.log 'componentWillMount'

  startCountdown: ->
    store.dispatch(type: 'startCountdown')

  render: ->
    div {},
      "Target: " + @props.target
      " Elapsed: " + @props.elapsed
      @renderFinished() if @props.finished
      @renderCountdown()
      @renderTasks()
      unless @props.running
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

  renderFinished: ->
    h1 {},
      'Finished!'
