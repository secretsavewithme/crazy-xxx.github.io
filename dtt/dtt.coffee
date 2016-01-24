{ a, button, div, form, img, h1, h2, h3, h4, input, label, li, option, p, select, small, span, strong, ul } = React.DOM
el = React.createElement

make = (prop, val) ->
  obj = {}
  obj[prop] = val
  obj

dup = (state, objs...) ->
  _.assign({}, state, objs...)

trainerLogic = Redux.combineReducers({gameParams, game})

store = Redux.createStore(trainerLogic)

DTTMain = React.createClass
  render: ->
    div className: "container",
      h1({}, 'Deepthroat Trainer'),
      if @props.game.started
        el(Game, @props.game)
      else
        el(StartSelector, @props.gameParams)

render = ->
  ReactDOM.render(
    el(DTTMain, store.getState()),
    document.getElementById('content'))

store.subscribe(render)
render()

#store.subscribe(-> console.log 'current state', JSON.stringify(store.getState()))
