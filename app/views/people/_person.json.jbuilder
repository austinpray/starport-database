json.extract! person, :id, :familyName, :givenName, :gender, :telephone, :email, :streetAddress, :postalCode, :postOfficeBoxNumber, :addressRegion, :addressLocality, :addressCountry, :homePlanet, :birthDate, :created_at, :updated_at
json.url person_url(person, format: :json)