require 'json'

class RadarChannel < ApplicationCable::Channel

  def subscribed
    stream_from "radar_stream"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def sendNewCoords(data)
    message = data['message']
    email = current_user[:email].to_sym
    new_state = {}

    #return if ship.nil?

    new_state[email] = {
        x: message['x'],
        y: message['y']
    }
    ActionCable.server.broadcast(
        "radar_stream",
        type: "state",
        time: Time.now.to_f,
        body: JSON.generate(new_state)
    )
  end

  def receiveNewState
  end
end
