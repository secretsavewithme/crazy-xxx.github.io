import React, { Component } from 'react';
import { Button, Grid, PageHeader, Panel } from 'react-bootstrap';

import ConfigPanel from './ConfigPanel'
import nextTask from './tasks'

class Game extends Component {
  state = {
    tasks: [{header: 'Introduction', intro: 'before we begin', task: 'Assume the postition. Prepare the dildo and the spit bowl. When ready, click "Next Challenge"'}]
  }

  handleNextTask = () => {
    const task = nextTask(this.state.tasks.length - 1, this.props.difficulty)
    this.setState({tasks: [task].concat(this.state.tasks)})
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
            {tasks.slice(1).map(t => <li>{t}</li>)}
          </ul>
        </div>)
    }
  }

  renderTasks() {
    return this.state.tasks.map(({header, intro, task}, i) =>
      <Panel
        key={header}
        header={<h3>{header}<br/><small>{intro}</small></h3>}
        bsStyle={i === 0 ? "primary" : "default"}
      >
        {this.renderTask(task)}
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
          <Game difficulty={this.state.difficulty} /> :
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
