import React, {Component} from "react";
import ConnectionIndicator from "./components/ConnectionIndicator";

const RADAR_WIDTH = 1000;
const RADAR_HEIGHT = 1000;

export default class Radar extends Component {
    constructor(props) {
        super(props);
        this.state = {
            connected: false
        };
    }

    componentDidMount() {
        App.cable.subscriptions.create("RadarChannel", {
            connected: () => {
                // Called when the subscription is ready for use on the server
                this.setState({
                    connected: true
                })
            },

            disconnected: function() {
                this.setState({
                    connected: false
                })
            },

            received: function(data) {
                // Called when there's incoming data on the websocket for this channel
                console.log(data);
            },

            sendNewCoords: function() {
                return this.perform('sendNewCoords');
            },

            receiveNewState: function() {
                return this.perform('receiveNewState');
            }
        });
    }

    render() {
        const {connected} = this.state;
        return <div>
            <ConnectionIndicator connected={connected} />
        </div>
    }
}