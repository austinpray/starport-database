class WelcomeController < ApplicationController

  def index
  end

  def dashboard
    @user = current_user
    @ship = current_user.ship
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
    @picture_options = SvgImage.all
  end

  def set_new_ship_picture
    id = params[:ship_id]
    ship = Ship.find(id)
    svg = SvgImage.find(params[:picture])
    ship.svg_image = svg
    return redirect_to launch_wizard_new_ship_done_path if ship.save

    redirect_to launch_wizard_set_new_ship_picture_path, alert: 'failed to save picture'
  end

  def new_ship_summary
    @wizard_step = 3
    @ship = current_user.ship
  end

  def radar
    @ship = current_user.ship
    @skip_footer = true
  end

  def new_color
    current_user.get_new_color
    redirect_to dashboard_path if current_user.save
  end
end
