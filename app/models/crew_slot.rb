class CrewSlot < ApplicationRecord
  belongs_to :specialty
  has_many :people, through: :crew_slot_assignments
end
