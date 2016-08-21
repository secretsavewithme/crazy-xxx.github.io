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
  currentLearning: -1
  pairs: combinePairs()

gxs = [ #http://gentlemanboners.tumblr.com/archive
  # 'http://66.media.tumblr.com/2f89f3f34d68ea4bca8611d1d49d24d3/tumblr_oc4k5qIUMD1unmtsfo1_1280.jpg',
  # 'http://67.media.tumblr.com/b3b07eacdc76bead27531a18d84598c4/tumblr_oc4mp6XlYh1unmtsfo1_1280.jpg',
  # 'http://66.media.tumblr.com/e12077b854342e61f521a98aa718ba56/tumblr_oc3asbyFir1unmtsfo1_1280.jpg',
  # 'http://67.media.tumblr.com/1c417d987228a81dcb55970443237a3b/tumblr_obzgzuNH5z1unmtsfo1_1280.jpg',
  'http://65.media.tumblr.com/2a364e7c86e3236c1ac8e2cb6b32f833/tumblr_njpduz9LOX1rodxovo6_1280.jpg',
  'http://65.media.tumblr.com/70adc6a801dd9e8cd8c66c5e70458a61/tumblr_njnha11WIq1rodxovo2_1280.jpg',
  'http://66.media.tumblr.com/921a7e8b72362699c5f372cd5f243cec/tumblr_nlcobhjaFf1rodxovo7_1280.png',
  'http://66.media.tumblr.com/d8efdf8a71cb33ef9a39bf8210c84e59/tumblr_njlmes8g0g1rodxovo3_1280.jpg'
]
cxs = [
  # 'http://66.media.tumblr.com/e4711d4ba3cf4550be9edbf3d952aca8/tumblr_oavj8rdcu71smjd03o1_1280.jpg',
  # 'http://67.media.tumblr.com/bf3fb8b3ff7ef7359cf692770f423db1/tumblr_oagmq610es1smjd03o1_1280.jpg',
  # 'http://66.media.tumblr.com/a2625616a8080f4d33e9d0d9cec3c42f/tumblr_o901637P6S1qdueojo1_1280.jpg',
  # 'http://66.media.tumblr.com/d100fd6fbee8188c2ea4fd1763e95d81/tumblr_o1nm920xfU1qfbh7io1_1280.jpg',
  'http://67.media.tumblr.com/acdc00fba1174c0400bf167534241b4a/tumblr_o74ou7Gc6p1qcv09ro3_1280.jpg',
  'http://66.media.tumblr.com/044dcc65c6b60dd40098f435530cd911/tumblr_nxn8ix0wSH1ro1zebo1_1280.jpg',
  'http://65.media.tumblr.com/ac00120ad8c7de3b1472a7c1adbb10d1/tumblr_nw2ih9zsjI1qkxrtro1_1280.png',
  'http://66.media.tumblr.com/328c3523d732d026f66f57a4a6eb64b9/tumblr_nw2ih9zsjI1qkxrtro4_1280.png',
]

combinePairs = ->
  sg = _.shuffle(gxs)
  sc = _.shuffle(cxs)
  _.map _.zip(sg, sc), (a) ->
    [a[0]].concat(getRandomsCxs(a[1]))

prepareTesting = (pairs) ->
  phase: 'testing'
  currentTest: -1
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
