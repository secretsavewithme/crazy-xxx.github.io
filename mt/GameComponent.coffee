GameComponent = React.createClass
  render: ->
    div {},
      if @learningPhase()
        @renderLearning()
      else
        @renderTesting()

  renderLearning: ->
    div {},
      div className: 'row',
        div className: 'col-xs-6',
          @gxImage()
        div className: 'col-xs-6',
          @cxImage()
      div className: 'row', style: {marginTop: 25},
        button type: "submit", className: "btn btn-primary btn-lg center-block", onClick: @nextLearning, 'Continue'

  renderTesting: ->
    div {},
      div className: 'row',
        div className: 'col-xs-6',
          @gxImage()
        div className: 'col-xs-6',
          @renderCxs()
      div className: 'row', style: {marginTop: 25},
        button type: "submit", className: "btn btn-primary btn-lg center-block", onClick: @nextTest, 'Continue'

  renderCxs: ->
    cxs = getRandomsCxs(@currentPair()[1])
    div {},
      _.map cxs, (cx) =>
        div className: 'row',
          @smallCxImage(cx)

  currentPair: ->
    if @learningPhase()
      @props.pairs[@props.currentLearning]
    else
      @props.pairs[@props.currentTest]

  learningPhase: ->
    'learning' == @props.phase

  gxImage: ->
    @halfSizeImage(@currentPair()[0], 'right')

  cxImage: ->
    @halfSizeImage(@currentPair()[1], 'left')

  halfSizeImage: (url, align) ->
    img src: url, style: {maxHeight: '80vh', maxWidth: '100%', float: align}

  smallCxImage: (url, align = 'left') ->
    img src: url, style: {maxHeight: '25vh', maxWidth: '100%', float: align, marginBottom: 10}

  nextLearning: ->
    store.dispatch(type: 'nextLearning')

  nextTest: ->
    store.dispatch(type: 'nextTest')
