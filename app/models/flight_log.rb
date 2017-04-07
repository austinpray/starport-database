# == Schema Information
#
# Table name: flight_logs
#
#  id         :integer          not null, primary key
#  trip_id    :integer
#  person_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FlightLog < ApplicationRecord
  belongs_to :trip
  belongs_to :person
end
