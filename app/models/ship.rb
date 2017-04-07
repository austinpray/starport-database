class Ship < ApplicationRecord
  has_many :crew_slot_assignments
end
