module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      user_id = cookies.signed['user.id']
      unless user_id
        reject_unauthorized_connection
      end
      verified_user = User.find_cached(user_id)
      if verified_user && cookies.signed['user.expires_at'] > Time.now
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
