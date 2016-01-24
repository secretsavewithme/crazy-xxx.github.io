Game = React.createClass
  startCountdown: ->
    store.dispatch(type: 'startCountdown')

  startAnother: ->
    store.dispatch(type: 'startAnother')

  render: ->
    div {},
      @renderFinished() if @props.finished
      @renderTasks()
      unless @props.running or @props.countdown
        button type: "submit", className: "btn btn-primary btn-lg center-block", onClick: @startCountdown, 'Click here when ready'

  countDownText: ->
    if @props.countdown or 0 == @props.countdown and not @props.tasks.length
      "Ready in #{@props.countdown + 1}..."
    else
      'Get ready...'

  renderTasks: ->
    [task, tasks...] = @props.tasks
    if task
      div className: 'panel panel-primary',
        @renderHeading('Remaining time: ' + task.time)
        div className: 'panel-body',
          p className: 'lead',
            strong {}, "#{task.desc} (#{task.elapsed}s)"
        ul className: 'list-group',
          _.map tasks, (task) ->
            li className: 'list-group-item text-muted', "#{task.desc} (#{task.elapsed}s)"
    else
      div className: 'panel panel-primary',
        @renderHeading(@countDownText())

  renderHeading: (heading) ->
    rightEl = if $('body').width() < 400 then small else span
    div className: 'panel-heading',
      h3 className: 'panel-title',
        heading
        rightEl className: 'pull-right',
          "Target: " + @props.target + ", Elapsed: " + @props.elapsed

  renderFinished: ->
    div {},
      h2 {},
        "Congratulations! You completed #{@props.elapsed} seconds of training!"
      button className: "btn btn-success btn-lg center-block", style: {marginBottom: 20}, onClick: @startAnother, 'Start another training'
