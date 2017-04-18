import React, {Component} from "react";
import ConnectionIndicator from "./components/ConnectionIndicator";

class Ship extends Component {
    render() {
        const {x, y} = this.props;
        return <div style={{top: y, left: x, position: "absolute", background: "red", width: "50px", height: "50px"}}>
            SHIP WEEE
        </div>
    }
}

const DOWN = 74;
const UP =  75;

export default class Radar extends Component {
    constructor(props) {
        super(props);
        this.state = {
            connected: false,
            current_user: null,
            x: 0,
            y: 0
        };
    }

    handleMove(e) {
        if (!this.state.connected) {
            return;
        }
        if (e.keyCode === DOWN) {
            this.setState({top: this.state.top + INCREMENT});
        }
        if (e.keyCode === UP) {
            this.setState({top: this.state.top - INCREMENT});
        }
    }

    componentDidMount() {
        console.log("mounted")
        const ws = App.cable.subscriptions.create("RadarChannel", {
            connected: () => {
                // Called when the subscription is ready for use on the server
                this.setState({ connected: true })
            },

            disconnected: () => {
                this.setState({
                    connected: false
                })
            },

            received: (data) => {
                console.log(data)
                switch(data.type) {
                    case "user":
                    case "state":
                        console.log(data);
                        if (this.state.time && this.state.time > data.time) {
                            // we have fresher data
                            return;
                        }
                        return this.setState({
                            time: data.time,
                            board: JSON.parse(data.body)
                        });
                }
            },

            sendNewCoords: function(x, y) {
                return ws.perform('sendNewCoords', {message: {x, y}});
            },

            receiveNewState: function() {
                return ws.perform('receiveNewState');
            }
        });
        this.setState({ws})
    }

    render() {
        const {connected} = this.state;
        return <div>
            <ConnectionIndicator connected={connected} />
            {this.state.ws && <button onClick={this.state.ws.sendNewCoords.bind(this, 1, 1)}>Test</button>}
            {this.state.board && Object.keys(this.state.board).map((key) => {
                return <Ship key={key} {...this.state.board[key]} />
            })}
        </div>
    }
}