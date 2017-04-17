App.radar = App.cable.subscriptions.create("RadarChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  sendNewCoords: function() {
    return this.perform('sendNewCoords');
  },

  receiveNewState: function() {
    return this.perform('receiveNewState');
  }
});
