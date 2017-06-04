import React, { Component } from 'react';
import { Button } from 'react-bootstrap';

class Game extends Component {
  render() {
    return <div>Game</div>
  }
}
class ConfigPanel extends Component {
  render() {
    return <div>ConfigPanel 123</div>
  }
}

class App extends Component {
  state = {
    started: false
  }

  render() {
    return (
      <div>
        {this.state.started ? <Game /> : <ConfigPanel />}
        <Button
          bsStyle="success"
          bsSize="large"
          href="http://react-bootstrap.github.io/components.html"
          target="_blank">
          View React Bootstrap Docs
        </Button>
      </div>
    );
  }
}

export default App;

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
