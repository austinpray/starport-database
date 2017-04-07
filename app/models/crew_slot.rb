# == Schema Information
#
# Table name: crew_slots
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text(65535)
#  specialty_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CrewSlot < ApplicationRecord
  belongs_to :specialty
  has_many :people, through: :crew_slot_assignments
  has_many :crew_slot_assignments
end
