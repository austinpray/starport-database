import Isvg from "react-inlinesvg";

import React, {Component} from "react";
import { Animate } from "react-move";
import ConnectionIndicator from "./components/ConnectionIndicator";
import _throttle from "lodash/throttle";
import _debounce from "lodash/debounce";
import _sample from "lodash/sample";
import _delay from "lodash/delay";
import _tail from "lodash/tail";
import _random from "lodash/random";


const INCREMENT = 100;
const ANIMATION_DURATION = 1000;

class Ship extends Component {
    render() {
        const {
            x,
            y,
            name,
            photo,
            showPulse = false
        } = this.props;
        const className = showPulse ? "pulse-ship" : "";
        return <div>
            <Animate
                // Set some default data
                default={{
                    x: 0,
                    y: 0
                }}
                // Update your data to whatever you want
                data={{x, y}}
                duration={ANIMATION_DURATION}
                easing='easeCubicInOut' // anything from https://github.com/d3/d3-ease
            >
                {({x, y}) => { // the child function is passed the current state of the data as an object
                    return (
                        <div className={className} style={{
                            top: y,
                            left: x,
                            position: "absolute",
                            transform: "translate(-50%, -50%)",
                            width: "50px",
                            height: "50px",
                            textAlign: "center"
                        }}>
                            <img src={photo} width="100%" height="100%" />
                            {name}
                        </div>
                    );
                }}
            </Animate>
        </div>
    }
}

const MAX = 5000;
function fixOutOfBounds(coord) {
    if (coord > MAX) {
        return MAX;
    }
    if (coord < 0) {
        return 0;
    }
    return coord;
}

export default class Radar extends Component {
    constructor(props) {
        super(props);
        this.state = {
            connected: false,
            current_user: null,
            wows: []
        };
        this.shipState = {
            x: 0,
            y: 0
        };
        const ws = App.cable.subscriptions.create("RadarChannel", {
            connected: () => {
                // Called when the subscription is ready for use on the server
                this.setState({ connected: true });
            },

            disconnected: () => {
                this.setState({
                    connected: false
                })
            },

            received: (data) => {
                const {x, y} = data;
                switch(data.type) {
                    case "wow":
                        const {color, uid} = data;
                        this.setState({
                            wows: [].concat(
                                this.state.wows,
                                [{
                                    color,
                                    uid,
                                    x: x + _sample([-3, -2, -1, 1, 2, 3]),
                                    y: y + _sample([-3, -2, -1, 1, 2, 3])
                                }])
                        });
                        _delay(() => {
                            this.setState({
                                wows: _tail(this.state.wows)
                            })
                        }, 1000);
                        return 0;
                    case "user":
                    case "state":
                        if (this.state.time && this.state.time > data.time) {
                            // we have fresher data
                            return;
                        }
                        const {user, ship_photo, ship_name} = data;
                        return this.setState({
                            time: data.time,
                            board: Object.assign({}, this.state.board, {[user]: {x, y, ship_photo, ship_name}})
                        });
                }
            },

            sendNewCoords: _throttle(function(x, y) {
                return ws.perform('sendNewCoords', {message: {x, y}});
            }, ANIMATION_DURATION/2),

            transmitWow: _throttle(() => {
                const {x, y} = this.shipState;
                return ws.perform('transmitWow', {message: {x, y}});
            }, 200)
        });

        this.state.ws = ws;

        this.keys = {};
        this.onUnloadBound = this.onUnload.bind(this)
    }

    onUnload() {
        if (this.state.ws) {
            this.state.ws.unsubscribe();
        }
        document.removeEventListener("turbolinks:before-visit", this.onUnloadBound);
    }

    componentWillUnmount() {
        document.removeEventListener("turbolinks:before-visit", this.onUnloadBound);
    }

    componentWillMount() {
        document.addEventListener("turbolinks:before-visit", this.onUnloadBound);
    }

    handleClick(e) {
        const parent = e.target.parentNode;
        const {top: parentTop, left: parentLeft} = parent.getBoundingClientRect();
        const newX = fixOutOfBounds(parent.scrollLeft + e.pageX - parentLeft);
        // 15 is margin
        const newY = fixOutOfBounds(parent.scrollTop + e.pageY - parentTop);
        this.shipState.x = newX;
        this.shipState.y = newY;
        this.setState({waypoint: {x: newX, y: newY}});
        this.state.ws.sendNewCoords(newX, newY);
    }

    transmitWowFactor() {
        this.state.ws.transmitWow();
    }

    render() {
        const {connected} = this.state;
        return <div className="radar-container">
            <div className="controls-header">
                <ConnectionIndicator connected={connected} />
                <div>
                    Your color: <i className="glyphicon glyphicon-user" style={{color: window.CURRENT_USER_COLOR}}></i>
                </div>
                <div>
                    Number of users online: {Object.keys(this.state.board || {}).length}
                </div>
                <div><button className="btn btn-sm btn-primary" disabled={!connected} onClick={this.transmitWowFactor.bind(this)}>Transmit WOW Factor</button></div>
            </div>
            <div className="board-container">
                {this.state.wows.map(function ({uid, x, y, color}) {
                    const style = {
                        position: "absolute",
                        left: x + _sample([-20, -10, 0, 10, 20]),
                        top: y + _sample([-20, -10, 0, 10, 20]),
                        transform: "translate(-50%, -50%)",
                        color,
                        zIndex: 99,
                        fontSize: _sample([110, 150, 100]) * _random(1, 1.5, true) + "%"
                    };
                    return <div key={uid} style={style}>
                        WOW
                    </div>
                })}
                <div style={{width: `${MAX}px`, height: `${MAX}px`}} onClick={this.handleClick.bind(this)}
                     className="board">
                    {this.state.waypoint &&
                        <i className="pulse"
                           style={{
                               position: "absolute",
                               transform: "translate(-50%, -50%)",
                               top: `${this.state.waypoint.y}px`,
                               left: `${this.state.waypoint.x}px`}} />}
                     {this.state.board && Object.keys(this.state.board).map((key) => {
                         const {x, y, ship_name, ship_photo} = this.state.board[key];
                         return <Ship key={key}
                                      showPulse={key === window.CURRENT_USER}
                                      name={ship_name}
                                      photo={ship_photo}
                                      x={x}
                                      y={y} />
                     })}
                </div>
            </div>
        </div>
    }
}