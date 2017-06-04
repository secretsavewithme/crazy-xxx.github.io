import React, { Component } from 'react';
import { Button, ButtonGroup, Col, Grid, ListGroup, ListGroupItem, PageHeader, Row } from 'react-bootstrap';

class Game extends Component {
  render() {
    return <div>Game</div>
  }
}
class ConfigPanel extends Component {
  render() {
    return (
      <div>
        <ListGroup>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty(-2)} active={this.props.difficulty === -2}>
            <strong>Very Easy:</strong> -2 to every dice roll
          </ListGroupItem>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty(-1)} active={this.props.difficulty === -1}>
            <strong>Easy:</strong> -1 to every dice roll
          </ListGroupItem>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty('lite')} active={this.props.difficulty === 'lite'}>
            <strong>Lite:</strong> You won't get a 6, rolls are 1-5 only.
          </ListGroupItem>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty(0)} active={this.props.difficulty === 0}>
            <strong>Standard:</strong> Standard 1-6 dice rolls.
          </ListGroupItem>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty(+1)} active={this.props.difficulty === 1}>
            <strong>Hard:</strong> +1 to every dice roll
          </ListGroupItem>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty(+2)} active={this.props.difficulty === 2}>
            <strong>Very hard:</strong> +2 to every dice roll
          </ListGroupItem>
          <ListGroupItem onClick={() => this.props.handleSetDifficulty(+6)} bsStyle="danger" active={this.props.difficulty === 6}>
            <strong>Throat Queen:</strong> Every roll is 6. Extreme difficulty!
          </ListGroupItem>
        </ListGroup>
        <Button
          bsStyle="success"
          bsSize="large"
          onClick={this.props.handleStart}>
          Start game
        </Button>
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
