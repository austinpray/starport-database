class Specialty < ApplicationRecord
  has_many :people, through: :specializations
  has_many :specializations
end
