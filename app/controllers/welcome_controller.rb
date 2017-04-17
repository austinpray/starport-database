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
    if session[:ship]
      @ship = Ship.find(session[:ship])
    end
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
    id = params[:ship_id]
    picture_key = params[:picture]
    ship = Ship.find(id)
    picture = @picture_options[picture_key.to_sym]
    logger.debug picture.inspect
    logger.debug picture.nil?
    return redirect_to launch_wizard_set_new_ship_picture_path, alert: 'that picture is not whitelisted' if picture.nil?
    ship.photo_url = picture[:url]
    return redirect_to launch_wizard_new_ship_done_path if ship.save

    redirect_to launch_wizard_set_new_ship_picture_path, alert: 'failed to save picture'
  end

  def new_ship_summary
    @wizard_step = 3
    @ship = Ship.find(params[:ship_id])
  end

  def radar
    @ship = Ship.find(session[:ship])
  end
end
