# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  danger_rating  :integer
#  duration       :integer
#  cost           :decimal(10, )
#  status         :string(255)
#  destination_id :integer
#  ship_id        :integer
#  facility_id    :integer
#  departure_date :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Trip < ApplicationRecord
  belongs_to :destination
  belongs_to :ship
  belongs_to :facility
end
