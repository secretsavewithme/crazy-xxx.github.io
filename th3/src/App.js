import React, {Component} from 'react'
import PropTypes from 'prop-types'
import {Button, Grid, PageHeader, Panel} from 'react-bootstrap'
import {isNumber} from 'lodash'

import ConfigPanel from './ConfigPanel'
import nextTask from './tasks'

class Game extends Component {
  static propTypes = {
    difficulty: PropTypes.number.isRequired,
  }

  state = {
    tasks: [{
      header: 'Introduction',
      intro: 'before we begin',
      task: 'Assume the postition. Prepare the dildo and the spit bowl. When ready, click "Next Challenge"'}],
  }

  timerCallback = () => {
    if (this.state.timerCountdown) {
      this.setState({timerCountdown: this.state.timerCountdown - 1})
    }
    else if (0 === this.state.timerCountdown) {
      this.setState({timerCountdown: null, timer: this.state.taskTimer})
    }
    else if (0 === this.state.timer) {
      clearInterval(this.state.timerInterval)
      this.setState({timer: null, taskTimer: null, timerInterval: null})
    }
    else {
      this.setState({timer: this.state.timer - 1})
    }
  }

  handleNextTask = () => {
    const task = nextTask(this.state.tasks.length - 1, this.props.difficulty)
    this.setState({
      tasks: [task].concat(this.state.tasks),
      showPunishment: false,
      taskTimer: task.timer})
  }

  handleStartTimer = () => {
    const timerInterval = setInterval(this.timerCallback, 1000)
    this.setState({timerCountdown: 3, timerInterval})
  }

  handleShowPunishment = () => {
    const {punishment} = this.state.tasks[0]
    this.setState({showPunishment: true, taskTimer: punishment && punishment.timer})
  }

  renderTask(task) {
    if (task.indexOf('\n') === -1) {
      return task
    }
    else {
      const tasks = task.split('\n')
      return (
        <div>
          {tasks[0]}
          <ul>
            {tasks.slice(1).map(t => <li key={t}>{t}</li>)}
          </ul>
        </div>)
    }
  }

  renderPunishment(punishment) {
    if (punishment) {
      return (
        <div>
          {punishment.intro}{' '}
          {this.state.showPunishment ?
            this.renderTask(punishment.text)
          :
            <Button bsStyle="danger" bsSize="xsmall" onClick={this.handleShowPunishment}>
              Get punishment
            </Button>
          }
        </div>)
    }
  }

  renderTasks() {
    return this.state.tasks.map(({header, intro, task, punishment}, i) =>
      <Panel
        key={header}
        header={<h3>{header}<br /><small>{intro}</small></h3>}
        bsStyle={i === 0 ? "primary" : "default"}
        footer={i === 0 && this.renderPunishment(punishment)}
      >
        {this.renderTask(task)}
      </Panel>)
  }

  renderTimerOrNextButton() {
    if (isNumber(this.state.timerCountdown)) {
      return <div>Get ready... Starting in {this.state.timerCountdown}</div>
    }
    else if (isNumber(this.state.timer)) {
      return <div>Hold it... {this.state.timer}</div>
    }
    else if (this.state.taskTimer) {
      return <Button bsSize="large" bsStyle="warning" block onClick={this.handleStartTimer}>Start timer</Button>
    }
    else {
      return <Button bsSize="large" block onClick={this.handleNextTask}>Next challenge</Button>
    }
  }

  render() {
    return (
      <div>
        {this.renderTimerOrNextButton()}
        <br />
        {this.renderTasks()}
      </div>)
  }
}

class App extends Component {
  state = {
    started: false,
    difficulty: 0,
  }

  render() {
    return (
      <Grid>
        <PageHeader>Throat Heaven 3</PageHeader>
        {this.state.started ?
          <Game difficulty={this.state.difficulty} /> :
          <ConfigPanel
            difficulty={this.state.difficulty}
            handleStart={() => this.setState({started: true})}
            handleSetDifficulty={(difficulty) => this.setState({difficulty})}
          />}
      </Grid>
    )
  }
}

export default App

// http://www.getdare.com/bbs/showthread.php?t=274819

// http://react-bootstrap.github.io/components.html

        // <Navbar inverse fixedTop>
        //   <Grid>
        //     <Navbar.Header>
        //       <Navbar.Brand>
        //         <a href="/">TH3</a>
        //       </Navbar.Brand>
        //       <Navbar.Toggle />
        //     </Navbar.Header>
        //   </Grid>
        // </Navbar>
