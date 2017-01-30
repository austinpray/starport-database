class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :type
      t.string :familyName
      t.string :givenName
      t.string :gender
      t.string :telephone
      t.string :email
      t.string :streetAddress
      t.string :postalCode
      t.string :postOfficeBoxNumber
      t.string :addressRegion
      t.string :addressLocality
      t.string :addressCountry
      t.string :homePlanet
      t.date :birthDate

      t.timestamps
    end
  end
end
