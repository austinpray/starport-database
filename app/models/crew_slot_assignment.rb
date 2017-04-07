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

class CrewSlotAssignment < ApplicationRecord
  belongs_to :person
  belongs_to :ship
  belongs_to :crew_slot
end
