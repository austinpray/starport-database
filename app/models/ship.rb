# == Schema Information
#
# Table name: ships
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  ship_class         :string(255)
#  description        :text(65535)
#  photo_url          :string(255)
#  passenger_capacity :integer
#  base_fare          :decimal(10, )
#  shield_rating      :integer
#  armor_rating       :integer
#  cargo_capacity     :decimal(10, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Ship < ApplicationRecord
  has_many :crew_slot_assignments
  has_one :user
  belongs_to :svg_image

  after_initialize :init

  def self.find_cached(id)
    Rails.cache.fetch("ship/#{id}", expires_in: 5.minute) do
      find(id)
    end
  end

  private

  def init
    self.svg_image ||= SvgImage.first
  end
end
