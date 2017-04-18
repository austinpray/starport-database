require 'json'

# FIXME: lol global var
$state = {}

class RadarChannel < ApplicationCable::Channel

  def subscribed
    stream_from "radar_stream"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def sendNewCoords(data)
    message = data['message']
    $state[current_user.email.to_sym] = {
        x: message['x'],
        y: message['y']
    }
    logger.debug $state.inspect
    ActionCable.server.broadcast(
        "radar_stream",
        type: "state",
        time: Time.now.to_f,
        body: JSON.generate($state),
    )
  end

  def receiveNewState
  end
end
