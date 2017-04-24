# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


=begin
Person Creation
  id                  :integer          not null, primary key
  type                :string(255)
  familyName          :string(255)
  givenName           :string(255)
  gender              :string(255)
  telephone           :string(255)
  email               :string(255)
  streetAddress       :string(255)
  postalCode          :string(255)
  postOfficeBoxNumber :string(255)
  addressRegion       :string(255)
  addressLocality     :string(255)
  addressCountry      :string(255)
  homePlanet          :string(255)
  birthDate           :date
  created_at          :datetime         not null
  updated_at          :datetime         not null
=end

=begin
	person_list = [
		["John", "Doe", "Male"]
		["John", "Snow", "Male"]
		["Jane", "Doe", "Female"]
		["Slim", "Shady", "Male"]
		["John", "Doe", "Male"]
		["He", "Mann", "Male"]
		["Francisco", "Juansicso", "Male"]
		["Elsa", "Asle", "Female"]
		["Richard", "Dorfenborder", "Male"]
		["Mili", "Vanili", "Male"]
		["Hatsune", "Miku", "Cyber-Female"]
		["Spongebob", "Squarepants", "Sponge"]
		["Homer", "Simpson", "Male"]
		["Hannibal", "Lecter", "Male"]
		["Mickey", "Mouse", "Mouse"]
		["Minnie", "Mouse", "Femouse"]
		["Marge", "Simpson", "Female"]
		["Jubilee", "McGee", "Female"]
		["Killer", "Frost", "Female"]
		["Wonder", "Woman", "Female"]
		["Bat", "Girl", "Female"]
		["Bat", "Mon", "Male"]
		["Super", "Man", "Male"]
		["Marge", "Simpson", "Female"]
		["Jimmie", "Neutron", "Male"]
		["Marge", "Simpson", "Female"]
		["Shawty", "Hawty", "Female"]
		["Haruhi", "Suzumiya", "Female"]
		["Marge", "Simpson", "Female"]
		["Poison", "Ivy", "Female"]
]

person_list.each do [ givenName, familyName, gender]
	Person.create( givenName: givenName, familyName: familyName, gender: gender )
end

# Cargo Creation
cargo_list = [
	[ description: "A lot of uranium"],
	[ description: "Just, like, an unecessary amount of uranium"],
	[ description: "Boomerangs"],
	[ description: "Mideval short sword"],
	[ description: "Grappling hook"],
]

cargo_list.each do [ description ]
	Cargo.create( description: description )
end

# Ship Creation
#  id                 :integer          not null, primary key
#  name               :string(255)
#  ship_class         :string(255)
#  description        :text(65535)
#  passenger_capacity :integer
#  base_fare          :decimal(10, )
#  shield_rating      :integer
#  armor_rating       :integer
#  cargo_capacity     :decimal(10, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
ship_list = [
	[ "USS Sponger", "Destroyer", "A Ship made of Sponge", 100, 45, 26, 53, 400 ],
  [ "USS Baylor", "Civilian", "University Research Ship", 100, 45, 26, 53, 400 ]
]

ship_list.each do [ name, class, desc, passCap, fare, shield, armor, cargoCap]
	Ship.create( name: name, ship_class: class, description: desc, passenger_capacity: passCap, base_fare: fare, shield_rating: shield, armor_rating: armor, cargo_capacity: cargoCap )
end

# Planet Creation
500.times do |x|
	randomNum = Random.rand(100000)
  Destination.create({name: "Planet #{randomNum}", distance: randomNum})
end
=end