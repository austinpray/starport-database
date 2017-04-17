class WelcomeController < ApplicationController
  before_filter :set_picture_options
  def set_picture_options
    @picture_options = {
      simple: {
        url: ActionController::Base.helpers.image_url("lander.svg")
      },
      spaceship: {
        url: ActionController::Base.helpers.image_url("spaceship.svg")
      }
    }
  end

  def index
  end

  def dashboard
    @user = current_user
  end

  def existing_or_new
    @wizard_step = 0
  end

  def new_ship_info
    @wizard_step = 1
    @ship = Ship.new
  end

  def new_ship_picture
    @wizard_step = 2
  end

  def set_new_ship_picture

  end
end
