d = -> parseInt(Math.random() * 10)
d19 = -> parseInt(1 + Math.random() * 9)

Duties = [
  '[Choose 2 but only charge for cheaper one]',
  'Suck for 5min',
  'Suck for 10min',
  'Suck for 5min, deepthroat every 30s',
  'Deepthroat 20x',
  'Deepthroat 40x',
  'Deepthroat 10x in 1min',
  'Deepthroat 20x in 90s, or deepthroat 100x',
  'Suck for 5min, then deepthroat 20x',
  'Suck for 10min, then deepthroat 40x',
]

Kinks = [
  '[Pick three]',
  'Wear nippleclamps',
  'Wear blindfold',
  'Wear collar',
  'Smear everything that comes out of your mouth on your face',
  'After doing your duty, slap your face with the dildo 30 times',
  'Spank your ass 50 times',
  'Moan and beg for more',
  'Wear nippleclamps & blindfold',
  'Wear nippleclamps & collar',
]

Twists = [
  'Gangbang: X roll is cumulative',
  null, null, null, null, null,
  'Cheap escape: do not collect money for this roll', #6
  'He brings his friend: do double amount of work', #7
  'His favorite bitch: do triple amount of work, get paid double', #8
  'Your pimp comes around: give him half of your money', #9
]

Xmoney = [1000, 20, 20, 30, 20, 35, 40, 70, 40, 55]
Ymoney = [0, 10, 10, 20, 40, 40, 10, 10, 20, 30]

rollCounter = 0

class Roll
  constructor: () ->
    @x = d()
    @y = d()
    @z = d()
    @x = @y = @z = 0 if @x == @y and @y == @z
    @x0 = [d19(), d19()]
    @y0 = _.first(_.shuffle([1..9]), 3)
    @key = rollCounter++

  numDuty: ->
    res = [@x]
    res.push(@y) if @y == @z
    res = res.concat(@x0) if _.contains(res, 0)
    res = [1.._.max(res)] if @z == 0
    res

  duty: ->
    duties = _.map(@numDuty(), (x) -> Duties[x])
    duties = _.map(duties, (duty) -> duty.replace(/(\d+)(min|x)/g, (_, p1, p2) -> "#{+p1 * 2}#{p2}")) if @z == 7
    duties = _.map(duties, (duty) -> duty.replace(/(\d+)(min|x)/g, (_, p1, p2) -> "#{+p1 * 3}#{p2}")) if @z == 8
    duties

  numKink: ->
    res = [@y]
    res.push(@x) if @x == @z
    res = res.concat(@y0) if _.contains(res, 0)
    res

  kink: ->
    _.map(@numKink(), (y) -> Kinks[y])

  twist: ->
    res = [@z]
    res.push(@x) if @x == @y
    _.compact(_.map(res, (z) -> Twists[z]))

  money: ->
    return 0 if 6 == @z
    moneys = _.map(@numDuty(), (x) -> Xmoney[x])
    moneys = [_.min(moneys)] if _.contains(@numDuty(), 0)
    moneys = moneys.concat(_.map(@numKink(), (y) -> Ymoney[y]))
    moneys = _.map(moneys, (n) -> n * 2) if 8 == @z
    _.reduce(moneys, ((memo, num) -> memo + num), 0)

  takesAll: ->
    0 == @x + @y + @z

  takesHalf: ->
    9 == @z

  debug: ->
    "x=#{@x} y=#{@y} z=#{@z} x0=#{@x0} y0=#{@y0}"

calcMoney = (rolls) ->
  if rolls.length
    [roll, rolls...] = rolls
    return 0 if roll.takesAll()
    m = roll.money() + calcMoney(rolls)
    if roll.takesHalf() then m / 2 else m
  else
    0

{ button, div, form, h1, label, li, option, p, select, small, table, tbody, td, th, tr, ul } = React.DOM

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
            option(key: x, value: x, "#{x} ($#{x}00)") for x in [1..10]), ' '
        button type: "submit", className: "btn btn-primary", 'Start'

Game = React.createClass
  getInitialState: ->
    money: 0
    target: @props.A * 100
    rolls: []

  createNextTask: (e) ->
    e.preventDefault()
    rolls = [new Roll()].concat(@state.rolls)
    money = calcMoney(rolls)
    @setState(rolls: rolls, money: money)

  rollB: ->
    @setState b: d()

  listify: (a) ->
    if a.length > 1
      ul {}, _.map(a, (el, i) -> li key: i, el)
    else
      a[0]

  finalDecision: ->
    can = @state.b < @props.A
    div className: "panel text-center #{if can then 'panel-success' else "panel-danger"}", style: {marginTop: 20},
      h1 {className: 'panel-heading panel-title'},
        "You #{if can then "can" else "can't"} cum!"
      "Your B is #{@state.b}"


  render: ->
    canGetNext = @state.money < @state.target
    beforeFinal = not canGetNext and @state.b == undefined
    finished = not canGetNext and not beforeFinal
    div {},
      div className: 'row',
        div className: 'col-xs-6', "Your money: $#{@state.money}"
        div className: 'col-xs-6 text-right', "Target money: $#{@state.target}"
      div className: 'row',
        div className: 'col-xs-12',
          canGetNext and
            button className: "btn btn-primary btn-lg center-block", onClick: @createNextTask,
              'Get next task'
          beforeFinal and
            button className: "btn btn-success btn-lg center-block", onClick: @rollB,
              'Roll for B'
          finished and
            @finalDecision()
      div className: 'row', style: {marginTop: 20},
        table className: 'table table-striped',
          tbody {},
            tr {},
              th className: 'col-xs-4', 'Duty'
              th className: 'col-xs-3', 'Kink'
              th className: 'col-xs-3', 'Twist'
              th className: 'col-xs-2', 'Money'
            _.map(@state.rolls, (roll, i) =>
              classes = if 0 == i then className: 'lead' else {}
              tr key: roll.key,
                td classes, @listify(roll.duty())
                td classes, @listify(roll.kink())
                td classes, @listify(roll.twist())
                td classes, "$#{roll.money()} #{roll.debug()}")


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
