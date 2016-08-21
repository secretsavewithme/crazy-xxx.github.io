GameComponent = React.createClass
  getInitialState: ->
    disabledContinue: true

  componentDidMount: ->
    @interval = setInterval =>
      allLoaded = true
      $('.observedImage').each (_, img) ->
        allLoaded &&= img.complete && img.naturalWidth > 0
      if allLoaded == @state.disabledContinue
        @setState(disabledContinue: !allLoaded)
    , 100
    console.log 'interval', @interval

  componentWillUnmount: ->
    console.log 'componentWillUnmount', @interval
    deleteInterval @interval if @interval

  render: ->
    div {},
      if @learningPhase()
        @renderLearning()
      else
        @renderTesting()
      @renderPreloader()

  renderLearning: ->
    div {},
      div className: 'row',
        div className: 'col-xs-6',
          @gxImage()
        div className: 'col-xs-6',
          @cxImage()
      div className: 'row', style: {marginTop: 25},
        button
          type: "submit",
          className: "btn btn-primary btn-lg center-block",
          onClick: @nextLearning,
          disabled: @state.disabledContinue,
          if @state.disabledContinue
            (img src: '../vendor/gears.svg')
          else
            'Continue'

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
    img src: url, className: 'observedImage', style: {maxHeight: '80vh', maxWidth: '100%', float: align}

  smallCxImage: (url, align = 'left') ->
    img src: url, className: 'observedImage', style: {maxHeight: '25vh', maxWidth: '100%', float: align, marginBottom: 10}

  nextLearning: ->
    @setState disabledContinue: true
    store.dispatch(type: 'nextLearning')

  nextTest: ->
    store.dispatch(type: 'nextTest')

  nextPair: ->
    if @learningPhase()
      @props.pairs[@props.currentLearning + 1]
    else
      @props.pairs[@props.currentTest + 1]

  renderPreloader: ->
    if pair = @nextPair()
      console.log 'pair', pair
      div style: {display: 'none'},
        _.map pair, (url) ->
          img src: url, className: 'observedImage', style: {width: 100, height: 100}
