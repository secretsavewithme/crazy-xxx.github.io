gameParamsInitialState =
  type: 'random'
  min: 5
  max: 10
  minutes: 3
  seconds: 300
  error: false

gameParamValid = (prop, val, state) ->
  return false unless _.isFinite(val) and +val > 0
  if prop == 'min'
    +val <= +state.max
  else if prop == 'max'
    +val >= +state.min
  else if prop == 'random'
    +state.min <= +state.max
  else
    true

gameParams = (state = gameParamsInitialState, action) ->
  switch action.type
    when 'changeType'
      dup(state, type: action.selected, error: not gameParamValid(action.selected, state[action.selected], state))
    when 'changeVal'
      dup(state, make(action.prop, action.val), error: not gameParamValid(action.prop, action.val, state))
    else
      state

calculateTargetTime = ->
  params = store.getState().gameParams
  switch params.type
    when 'random'
      _.random(params.min * 60, params.max * 60)
    when 'minutes'
      params.minutes * 60
    when 'seconds'
      params.seconds

