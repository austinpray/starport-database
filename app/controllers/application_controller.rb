class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # lol
  def user_is_austin?
    current_user.email === 'austin@austinpray.com'
  end

  def restrict_access_to_admins
    redirect_back fallback_location: welcome_index_path, alert: 'sorry only austin can do that' unless user_is_austin?
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end
end
