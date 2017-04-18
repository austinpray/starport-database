import React, {Component} from "react";
import ConnectionIndicator from "./components/ConnectionIndicator";

const RADAR_WIDTH = 1000;
const RADAR_HEIGHT = 1000;

class Ship extends Component {

}

export default class Radar extends Component {
    constructor(props) {
        super(props);
        this.state = {
            connected: false
        };
    }

    componentDidMount() {
        console.log("mounted")
        const ws = App.cable.subscriptions.create("RadarChannel", {
            connected: () => {
                // Called when the subscription is ready for use on the server
                this.setState({
                    connected: true
                })
            },

            disconnected: () => {
                this.setState({
                    connected: false
                })
            },

            received: (data) => {
                if (data.type === "state") {
                    console.log(data);
                    if (this.state.time && this.state.time > data.time) {
                        // we have fresher data
                        return;
                    }
                    this.setState({
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
        </div>
    }
}