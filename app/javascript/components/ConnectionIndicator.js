import React from "react";

export default function ConnectionIndicator({connected = false}) {
    return <div>
        {connected ? "Connected" : "Not Connected"}
    </div>
}