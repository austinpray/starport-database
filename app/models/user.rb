# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init

  after_update :bust_cache


  belongs_to :ship, optional: true

  def get_new_color
    self.color = [
      'red'.paint.palette.monochromatic(size: 64, as: :hex),
      'green'.paint.palette.monochromatic(size: 64, as: :hex),
      'orange'.paint.palette.monochromatic(size: 64, as: :hex),
      'aqua'.paint.palette.monochromatic(size: 64, as: :hex),
      'fuchsia'.paint.palette.monochromatic(size: 64, as: :hex)
    ].flatten.sample
    self.color = color.paint.lighten(50) if color.paint.dark?
  end

  def self.find_cached(id)
    Rails.cache.fetch("user/#{id}", expires_in: 5.minute) do
      find(id)
    end
  end

  private

  def bust_cache
    Rails.cache.delete("user/#{id}")
  end

  def init
    self.color ||= get_new_color
  end
end
