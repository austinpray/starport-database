class CrewSlotAssignment < ApplicationRecord
  belongs_to :person
  belongs_to :ship
  belongs_to :crew_slot
end
