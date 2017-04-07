# == Schema Information
#
# Table name: destinations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  distance    :decimal(10, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Destination < ApplicationRecord
end
