gameInitialState =
  started: false

game = (state = gameInitialState, action) ->
  switch action.type
    when 'startGame'
      newState(state, started: true, target: calculateTargetTime())
    when 'startCountdown'
      newState(state, countdown: 3)
    when 'decreaseCountdown'
      newState(state, countdown: state.countdown - 1)
    else
      state

timer = ->
  game = store.getState().game
  return unless game.started
  if game.countdown
    store.dispatch(type: 'decreaseCountdown')
  else
    store.dispatch(type: 'nextTask')

setInterval(timer, 1000)
