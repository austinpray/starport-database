# == Schema Information
#
# Table name: facilities
#
#  id                 :integer          not null, primary key
#  type               :string(255)
#  ship_id            :integer
#  parent_terminal_id :integer
#  display_name       :string(255)
#  slug               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class FacilityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
