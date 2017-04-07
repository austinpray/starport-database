# == Schema Information
#
# Table name: specialties
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Specialty < ApplicationRecord
  has_many :people, through: :specializations
  has_many :specializations
end
