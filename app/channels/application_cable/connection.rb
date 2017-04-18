# FIXME: global var cache reeee
$user_cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 30.minute)

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
      cached_user = $user_cache.fetch(user_id)
      if cached_user
        verified_user = cached_user
      else
        verified_user = User.find_by(id: user_id)
        $user_cache.write(user_id, verified_user)
      end
      if verified_user && cookies.signed['user.expires_at'] > Time.now
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
