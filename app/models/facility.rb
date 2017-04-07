class Facility < ApplicationRecord
  belongs_to :ship
  belongs_to :parent_terminal, class_name: "Facility"
end
