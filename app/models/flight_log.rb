class FlightLog < ApplicationRecord
  belongs_to :trip
  belongs_to :person
end
