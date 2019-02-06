import * as React from "react";

interface Props { }

interface State {
  count: number;
}

export class HelloWorld extends React.Component<Props, State> {
  interval: NodeJS.Timeout;

  constructor(props: Props) {
    super(props);
    this.bind();
    this.state = {
      count: 0
    }
  }

  bind() {
    this.tick = this.tick.bind(this);
  }

  componentDidMount() {
    this.interval = setInterval(this.tick, 1000)
  }

  render() {
    return (
      <>
        <div>Hello World!!!</div>
        <div>{this.state.count}</div>
      </>
    )
  }

  tick() {
    this.setState({
      count: this.state.count + 1
    })
  }
}

export default HelloWorld;
