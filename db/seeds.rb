require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

now = Time.now

# create an svg
svg_image_example = SvgImage.create(data: File.read(Rails.root.join('lib',
                                                           'assets',
                                                           'svg',
                                                           'spaceship.svg')),
                           name: "svg-#{now.getutc}",
                           source: 'seeds file')

# create some ships
ship1 = Ship.create(armor_rating: 10,
                    base_fare: 100.0,
                    cargo_capacity: 100.0,
                    description: "Ship 1 #{now.getutc}",
                    name: "Ship 1 #{now.getutc}",
                    passenger_capacity: 100,
                    shield_rating: 100,
                    ship_class: 'destroyer')


ship2 = Ship.create(armor_rating: 10,
                    base_fare: 200.0,
                    cargo_capacity: 100.0,
                    description: "Ship 2 #{now.getutc}",
                    name: "Ship 2 #{now.getutc}",
                    passenger_capacity: 100,
                    shield_rating: 100,
                    ship_class: 'cruiser')

ship3 = Ship.create(armor_rating: 10,
                    base_fare: 300.0,
                    cargo_capacity: 100.0,
                    description: "Ship 3 #{now.getutc}",
                    name: "Ship 3 #{now.getutc}",
                    passenger_capacity: 100,
                    shield_rating: 100,
                    ship_class: 'corsair')

# associate those ships with the svg we made
ship1.svg_image = svg_image_example
ship2.svg_image = svg_image_example
ship3.svg_image = svg_image_example

# grab a bunch of random people
people_json = JSON.parse(File.read(Rails.root.join('lib', 'data', 'people.json')))

def random_date(min_year, max_year)
  [
    (min_year..max_year).to_a.sample,
    (1..12).to_a.sample,
    (1..20).to_a.sample
  ].join('-')
end

def person_json_to_model_hash(person_json)
  {
    addressCountry: person_json['nat'],
    addressLocality: person_json['location']['city'],
    addressRegion: person_json['location']['state'],
    birthDate: person_json['dob'],
    email: person_json['email'],
    familyName: person_json['name']['last'],
    gender: person_json['gender'],
    givenName: person_json['name']['first'],
    homePlanet: 'Earth',
    postalCode: person_json['location']['postcode'],
    streetAddress: person_json['location']['street'],
    telephone: person_json['phone']
  }
end

# transform user json into a ruby array of hashes that match our schema
people = people_json['results'].map { |p| person_json_to_model_hash p }

# commit to schema
people_models = Person.create(people)

# give each person some cargo
people_models.each do |person|
  Cargo.create(description: "#{person.givenName} #{person.familyName}'s cargo",
               weight: [10.0, 100.0].sample,
               safety_rating: [1, 5, 10].sample,
               person_id: person.id)
end

# let's create the pilot speciality
pilot_speciality = Specialty.create(name: 'pilot', description: 'pilot certification')

# take 1/3 of the new users and make them pilots
pilots = people_models[0..(people_models.count * 0.33).floor]

# 2/3 normie passenger people
normies = people_models[(people_models.count * 0.33).floor..-1]

pilots.each do |pilot|
  Specialization.create(person_id: pilot.id, specialty_id: pilot_speciality.id)
end

# let's create a CrewSlot for pilot
pilot_slot = CrewSlot.create(name: 'pilot', description: 'pilot seat')

# let's assign 3 pilots to 3 ships
CrewSlotAssignment.create(crew_slot_id: pilot_slot.id,
                          ship_id: ship1.id,
                          person_id: pilots[0].id)
CrewSlotAssignment.create(crew_slot_id: pilot_slot.id,
                          ship_id: ship2.id,
                          person_id: pilots[1].id)
CrewSlotAssignment.create(crew_slot_id: pilot_slot.id,
                          ship_id: ship3.id,
                          person_id: pilots[2].id)

# so now the ships have pilots let's create some trips for them to go on
destination = Destination.create(name: "Planet #{SecureRandom.uuid}",
                                 description: 'a truly interesting planet',
                                 distance: (10000..10000000).to_a.sample)

# trips have to leave from a dock
# docks need a terminal though
terminal_uuid = SecureRandom.uuid
terminal = Facility.create(display_name: "Terminal #{terminal_uuid}",
                           slug: "terminal_#{terminal_uuid}")

# create dock and dock ship1 at it
dock_uuid = SecureRandom.uuid
dock = Facility.create(display_name: "Dock #{dock_uuid}",
                       slug: "dock_#{dock_uuid}",
                       parent_terminal: terminal,
                       ship_id: ship1.id)

# create three trips
offset = 10
trips = []
[ship1, ship2, ship3].each do |ship|
  trips.push(Trip.create(destination_id: destination.id,
                         facility_id: dock.id,
                         ship_id: ship.id,
                         cost: (ship.base_fare * destination.distance),
                         danger_rating: [1, 2, 3].sample,
                         duration: 1000,
                         departure_date: Time.now + offset.days,
                         status: 'waiting'))
  offset = 2 * offset + [1, 5, 11].sample
end

normie_groups = normies.in_groups(3, false)

normie_groups.each do |group|
  trip = trips.pop
  group.each do |normie|
    FlightLog.create(person_id: normie.id, trip_id: trip.id)
  end
end



