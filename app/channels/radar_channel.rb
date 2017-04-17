require 'json'
require 'securerandom'

class RadarChannel < ApplicationCable::Channel

  def subscribed
    stream_from "radar_stream"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def sendNewCoords(data)
    message = data['message']

    ActionCable.server.broadcast(
        "radar_stream",
        type: "state",
        time: Time.now.to_f,
        user: current_user.email,
        ship_name: current_user.ship.name,
        ship_photo: current_user.ship.svg_image.colorized_image_url(current_user.color),
        color: current_user.color,
        x: message['x'],
        y: message['y']
    )
  end

  def transmitWow(data)
    message = data['message']
    ActionCable.server.broadcast(
        "radar_stream",
        type: "wow",
        color: %w(RED MAROON YELLOW OLIVE LIME GREEN AQUA TEAL BLUE NAVY FUCHSIA PURPLE INDIGO).sample,
        uid: SecureRandom.uuid,
        x: message['x'],
        y: message['y']
    )
  end

end
