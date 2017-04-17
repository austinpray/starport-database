import React from "react";

export default function ConnectionIndicator({connected = false}) {
    return <div className={connected ? "text-success" : "text-danger"}>
        {connected ? <i className="glyphicon glyphicon-ok" /> : <i className="glyphicon glyphicon-scissors" />}
        <span> </span>
        {connected ? "Connected" : "Not Connected"}
    </div>
}