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

require 'test_helper'

class FlightLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
