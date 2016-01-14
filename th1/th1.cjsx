{ button, div, form, img, h1, h3, h4, input, label, li, option, p, select, span, strong, ul } = React.DOM

TH1Main = React.createClass
  getInitialState: ->
    started: false

  startAnother: ->
    @setState started: false, A: undefined

  render: ->
    div className: "container",
      h1({}, 'TH1Main'),
      # if @state.started
      #   <Game A={@state.A} startAnother={@startAnother} />
      # else
      #   <StartSelector started={@startGame} A={@state.A} />

ReactDOM.render <TH1Main />, document.getElementById('content')
