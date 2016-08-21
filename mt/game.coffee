gameInitialState =
  started: false

game = (state = gameInitialState, action) ->
  switch action.type
    when 'startGame'
      dup(state, startingGameState())
    when 'nextLearning'
      if state.currentLearning + 1 < state.pairs.length
        dup(state, currentLearning: state.currentLearning + 1)
      else
        dup(state, prepareTesting(state.pairs))
    when 'nextTest'
      if state.currentTest + 1 < state.pairs.length
        dup(state, currentTest: state.currentTest + 1)
      else
        dup(state, 1/0)
    else
      state

startingGameState = ->
  started: true
  phase: 'learning'
  currentLearning: 0
  pairs: combinePairs()

gxs = [ #http://gentlemanboners.tumblr.com/archive
  'http://66.media.tumblr.com/2f89f3f34d68ea4bca8611d1d49d24d3/tumblr_oc4k5qIUMD1unmtsfo1_1280.jpg',
  'http://67.media.tumblr.com/b3b07eacdc76bead27531a18d84598c4/tumblr_oc4mp6XlYh1unmtsfo1_1280.jpg',
  'http://66.media.tumblr.com/e12077b854342e61f521a98aa718ba56/tumblr_oc3asbyFir1unmtsfo1_1280.jpg',
  'http://67.media.tumblr.com/1c417d987228a81dcb55970443237a3b/tumblr_obzgzuNH5z1unmtsfo1_1280.jpg',
]
cxs = [
  'http://66.media.tumblr.com/e4711d4ba3cf4550be9edbf3d952aca8/tumblr_oavj8rdcu71smjd03o1_1280.jpg',
  'http://67.media.tumblr.com/bf3fb8b3ff7ef7359cf692770f423db1/tumblr_oagmq610es1smjd03o1_1280.jpg',
  'http://66.media.tumblr.com/a2625616a8080f4d33e9d0d9cec3c42f/tumblr_o901637P6S1qdueojo1_1280.jpg',
  'http://66.media.tumblr.com/d100fd6fbee8188c2ea4fd1763e95d81/tumblr_o1nm920xfU1qfbh7io1_1280.jpg',
]

combinePairs = ->
  sg = _.shuffle(gxs)
  sc = _.shuffle(cxs)
  _.zip(sg, sc)

prepareTesting = (pairs) ->
  phase: 'testing'
  currentTest: 0
  pairs: _.shuffle(pairs)

getRandomsCxs = (cx) ->
  res = [cx]
  while res.length < 3
    rc = _.sample(cxs)
    res.push(rc) unless _.contains(res, rc)
  res

wait = 0
timer = ->
  game = store.getState().game
  return unless game.started
  if game.countdown and (not responsiveVoice.isPlaying() or wait++ > 1) # kludge to avoid missing countdown
    wait = 0
    store.dispatch(type: 'decreaseCountdown')
  else if game.running
    if 0 == game.tasks.length or 0 == game.tasks[0].time
      store.dispatch(type: 'nextTask')
    else
      store.dispatch(type: 'decreaseTask')

setInterval(timer, 1000)
