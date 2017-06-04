import React, { Component } from 'react';
import { Button, Grid, PageHeader, Panel } from 'react-bootstrap';
import { random } from 'lodash'

import ConfigPanel from './ConfigPanel'

const task01 = [
  'lick the dildo 10 times',
  'lick the dildo 15 times',
  'put the head of your dildo in your mouth for 10 seconds',
  'put the head of your dildo in your mouth for 15 seconds',
  'lick the dildo 10 times and put the head of your dildo in your mouth for 10 seconds',
  'lick the dildo 15 times and put the head of your dildo in your mouth for 15 seconds' ]

const task02 = [
  'swallow it until you get tears in eyes',
  'slowly swallow it down your throat 1 time',
  'slowly swallow it down your throat 2 times',
  'slowly swallow it down your throat 3 times',
  'quickly swallow it down your throat 3 times',
  'slowly swallow it down your throat 3 times then quickly swallow it down your throat 3 times',
]

const nextTask = (num) => {
  switch(num) {
    case 1: return {
      header: 'Challenge 01. Starting it easy',
      intro: 'So you decided to be a throat whore today, you will get more than you expect, but you should start slowly, enjoy it.',
      task: task01[random(5)]}
    case 2: return {
      header: 'Challenge 02. Getting into action',
      intro: 'Bored from licking and not getting full candy? Dont worry bitch, things are getting more interesting.',
      task: task02[random(5)]}
  }
}

class Game extends Component {
  state = {
    tasks: [{header: 'Introduction', intro: 'before we begin', task: 'Assume the postition. Prepare the dildo and the spit bowl. When ready, click "Next Challenge"'}]
  }

  handleNextTask = () => {
    const task = nextTask(this.state.tasks.length)
    this.setState({tasks: [task].concat(this.state.tasks)})
  }

  renderTasks() {
    return this.state.tasks.map(({header, intro, task}, i) =>
      <Panel
        key={header}
        header={<h3>{header} <small>{intro}</small></h3>}
        bsStyle={i === 0 ? "primary" : "default"}
      >
        {task}
      </Panel>)
  }

  render() {
    return (
      <div>
        <Button bsSize="large" block onClick={this.handleNextTask}>Next challenge</Button>
        <br/>
        {this.renderTasks()}
      </div>)
  }
}

class App extends Component {
  state = {
    started: false,
    difficulty: 0
  }

  render() {
    return (
      <Grid>
        <PageHeader>Throat Heaven 3</PageHeader>
        {this.state.started ?
          <Game /> :
          <ConfigPanel
            difficulty={this.state.difficulty}
            handleStart={() => this.setState({started: true})}
            handleSetDifficulty={(difficulty) => this.setState({difficulty})}
          />}
      </Grid>
    );
  }
}

export default App;

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
