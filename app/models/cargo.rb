# == Schema Information
#
# Table name: cargo
#
#  id            :integer          not null, primary key
#  safefy_rating :integer
#  description   :text(65535)
#  person_id     :integer
#  weight        :decimal(10, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Cargo < ApplicationRecord
  belongs_to :person
end
