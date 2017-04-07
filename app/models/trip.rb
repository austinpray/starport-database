class Trip < ApplicationRecord
  belongs_to :destination
  belongs_to :ship
  belongs_to :facility
end
