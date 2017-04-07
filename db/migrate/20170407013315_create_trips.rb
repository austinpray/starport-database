class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.integer :danger_rating
      t.integer :duration
      t.decimal :cost
      t.string :status
      t.references :destination, foreign_key: true
      t.references :ship, foreign_key: true
      t.references :facility, foreign_key: true
      t.datetime :departure_date

      t.timestamps
    end
  end
end
