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

require 'test_helper'

class SpecialtyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
