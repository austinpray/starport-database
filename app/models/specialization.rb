# == Schema Information
#
# Table name: specializations
#
#  id           :integer          not null, primary key
#  person_id    :integer
#  specialty_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Specialization < ApplicationRecord
  belongs_to :person
  belongs_to :specialty
end
