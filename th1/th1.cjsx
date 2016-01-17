{ a, button, div, form, img, h1, h3, h4, input, label, li, option, p, select, span, strong, ul } = React.DOM
el = React.createElement

row = (optsOrContent, maybeContent) ->
  if maybeContent
    content = maybeContent
    opts = optsOrContent
  else
    content = optsOrContent
    opts = {}
  div key: opts.key, className: 'row', style: {marginTop: 20, marginBottom: opts.marginBottom}, content

fullRow = (optsOrContent, maybeContent) ->
  if maybeContent
    content = maybeContent
    opts = optsOrContent
  else
    content = optsOrContent
    opts = {}
  row(opts,
    div(className: "col-xs-12 #{opts.additionalClass}", content))

d16 = -> parseInt(1 + Math.random() * 6)

Panel = React.createClass
  getDefaultProps: ->
    panelClass: 'panel-default'

  render: ->
    panelClass = 'panel ' + if _.isUndefined(@props.primaryPanel)
      @props.panelClass
    else
      if @props.primaryPanel then 'panel-primary' else 'panel-default'
    div className: panelClass,
      if @props.heading
        div className: 'panel-heading',
          h3 className: 'panel-title', @props.heading
      div className: 'panel-body', @props.body

TimerButton = React.createClass
  getInitialState: ->
    countdown: undefined
    timer: undefined
    done: false

  startTimer: ->
    @setState(countdown: 3)
    @interval = setInterval @timerCallback, 1000

  timerCallback: ->
    if @state.countdown > 0
      @setState(countdown: @state.countdown - 1, timer: @props.seconds)
    else if @state.timer > 0
      @setState(timer: @state.timer - 1, done: 1 == @state.timer)
    else if @state.timer == 0
      clearInterval @interval
      @interval = 0

  componentWillUnmount: ->
    clearInterval @interval if @interval

  render: ->
    if @state.countdown
      #@props.speak("Ready in #{@state.countdown}...")
      p className: 'lead', "Ready in #{@state.countdown}..."
    else if @state.timer
      #@props.speak("Ready in #{@state.countdown}...")
      p className: 'lead', "Hold it! #{@state.timer}..."
    else if @state.done
      #@props.speak("Ready in #{@state.countdown}...")
      p className: 'lead', "Done. If you couldn't make it, try again and hold it as long as you can this time."
    else
      button className: "btn btn-warning btn-lg", onClick: @startTimer, style: {marginRight: 20}, 'Start timer'

Game = React.createClass
  getInitialState: ->
    position: @randomPosition()
    nextTask: 0
    tasks: []

  randomPosition: ->
    _.sample(['On the floor, kneeling', 'On the floor, ass on the ground between your legs', 'Neck on border of your bed', 'Sitting in the bathtub', 'Standing'])

  tasks: [
    #0
    ['Lick on it','Gag on it 5 times','Gag on it 10 times','Swallow it down your throat 5 times','Swallow it down your throat 10 times',
        'Gag on it 15 times, then swallow it down your throat 15 times'],
    #1
    ['Very slowly, go deeper and deeper','Push it down your throat and leave it there for 3 seconds.','Push it down your throat and leave it there for 6 seconds.',
         'Push it in as fast as you can and leave it there for 10 seconds','Push it in as fast as you can and leave it there for 15 seconds',
         'Push it into your throat and out as fast you can 3 times, repeat it 5 times',],
    #2
    [],
    #3
    ['Play with your spit with both hands','I want to see your face full of spit','Get all that spit back into your dirty mouth, after that back into the bowl, slowly',
         'Gather all the spit in your hands, then suck it back into your mouth','Get all that spit back into your dirty mouth and swallow it',
         'Take all that spit and grease it on your belly, tits and face',],
  ]

  randomTask: (num) ->
    _.sample(@tasks[num])

  timerTask: ->
    d3 = d16()
    secs = 0
    secs += d16() while d3--
    secs

  speak: (task) ->
    responsiveVoice.speak(task, "UK English Female", rate: 0.8) if @props.speechEnabled

  getNextTask: ->
    timerTask = 2 == @state.nextTask
    task = if timerTask
      "Hold your dildo in your throat for #{@timerTask()} seconds."
    else
      @randomTask(@state.nextTask)
    secs = +m[1] if m = task.match(/(\d+) seconds/)
    @speak(task)
    @setState(
      nextTask: 1 + @state.nextTask,
      tasks: [task].concat(@state.tasks),
      timerSecs: secs)

  render: ->
    div {},
      @renderButton()
      @renderTasks()
      @renderPosition()

  renderPosition: ->
    el Panel, primaryPanel: 0 == @state.nextTask, heading: 'Position', body: @state.position

  renderTasks: ->
    _.map(@state.tasks, (task, i) =>
      n = @state.nextTask - i
      el Panel, key: "task" + n, primaryPanel: 0 == i, heading: 'Task ' + n, body: task)

  renderButton: ->
    fullRow(marginBottom: 20,
      if @state.nextTask < @tasks.length
        div className: 'text-center center-block',
          if @state.timerSecs
            el TimerButton, key: 'timer' + @state.nextTask, seconds: @state.timerSecs, speak: @speak
          button className: "btn btn-primary btn-lg ", onClick: @getNextTask, 'Get next task'
      else
        button className: "btn btn-success btn-lg center-block", onClick: @props.startAnother, 'Start another game')


TH1Main = React.createClass
  getInitialState: ->
    started: false
    speechEnabled: @isSpeechEnabled()

  isSpeechEnabled: ->
    window.localStorage?.speechEnabled == 'true'

  startAnother: ->
    @setState started: false

  startGame: ->
    @setState started: true

  toggleSpeech: ->
    speechEnabled = not @state.speechEnabled
    window.localStorage?.speechEnabled = speechEnabled
    @setState speechEnabled: speechEnabled

  render: ->
    div className: "container",
      h1({}, 'Throat Heaven 1'),
      @renderIntroduction()
      if @state.started
        el(Game, startAnother: @startAnother, speechEnabled: @state.speechEnabled)
      else
        @renderStartGameButton()
      @renderFooter()

  renderFooter: ->
    div className: 'row', style: {marginTop: 20},
      div className: "col-xs-5",
        label {},
          (input type: 'checkbox', checked: @state.speechEnabled, onChange: @toggleSpeech),
          ' Enable speech'
      div className: "col-xs-7",
        p className: 'pull-right lead',
          'Based on '
          a href: 'http://www.getdare.com/bbs/showthread.php?t=176573', target: '_blank',
            'Throat Heaven 1 dare'

  renderStartGameButton: ->
    fullRow button className: "btn btn-primary btn-lg center-block", onClick: @startGame, 'Start a new dare'

  renderIntroduction: ->
    el Panel,
      primaryPanel: not @state.started,
      heading: 'Introduction',
      body:
        div {},
          p {}, "Get naked. Grab your doubledildo or something that you can swallow."
          p {}, "Place a bowl under your face. You will create lots of spit, don't swallow it, the bowl has to be full of your spit."
          p {}, "Roll to determine how you must suck the dildo. "

ReactDOM.render(
  el(TH1Main, null),
  document.getElementById('content'))
