# == Schema Information
#
# Table name: people
#
#  id                  :integer          not null, primary key
#  type                :string(255)
#  familyName          :string(255)
#  givenName           :string(255)
#  gender              :string(255)
#  telephone           :string(255)
#  email               :string(255)
#  streetAddress       :string(255)
#  postalCode          :string(255)
#  postOfficeBoxNumber :string(255)
#  addressRegion       :string(255)
#  addressLocality     :string(255)
#  addressCountry      :string(255)
#  homePlanet          :string(255)
#  birthDate           :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
