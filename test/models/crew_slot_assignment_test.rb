# == Schema Information
#
# Table name: crew_slot_assignments
#
#  id           :integer          not null, primary key
#  person_id    :integer
#  ship_id      :integer
#  crew_slot_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CrewSlotAssignmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
