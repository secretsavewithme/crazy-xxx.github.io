StartSelector = React.createClass
  getInitialState: ->
    value: 0

  handleSubmit: (e) ->
    e.preventDefault()
    @props.started(@state.value)

  handleChange: (e) ->
    @setState value: e.target.value

  render: ->
    <div>
      <p className="lead">
        The game is not started. To start it select a value for A (target amount of money) and press Start.</p>
      <form className="form-inline" onSubmit={@handleSubmit}>
        <div className="form-group">
          <label>A =</label>
          <select name='A' className="form-control" onChange={@handleChange}>
            <option value=0>Random</option>
            {<option key={x}>{x}</option> for x in [1..10]}
          </select>
        </div>{' '}
        <button type="submit" className="btn btn-primary">Start</button>
      </form>
    </div>

Game = React.createClass
  render: ->
    <div>
      Target money: ${@props.A * 100}
    </div>


OWRMain = React.createClass
  getInitialState: ->
    started: false

  startGame: (a) ->
    a ||= parseInt(1 + Math.random() * 10)
    @setState started: true, A: a

  render: ->
    <div className="OWRMain container">
      <h1>OWRMain</h1>
      {if @state.started then <Game A={@state.A} /> else <StartSelector started={@startGame} />}
    </div>

ReactDOM.render <OWRMain />, document.getElementById('content')
