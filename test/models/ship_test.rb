# == Schema Information
#
# Table name: ships
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  ship_class         :string(255)
#  description        :text(65535)
#  photo_url          :string(255)
#  passenger_capacity :integer
#  base_fare          :decimal(10, )
#  shield_rating      :integer
#  armor_rating       :integer
#  cargo_capacity     :decimal(10, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class ShipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
