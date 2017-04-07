class CreateShips < ActiveRecord::Migration[5.0]
  def change
    create_table :ships do |t|
      t.string :name
      t.string :class
      t.text :description
      t.string :photo_url
      t.integer :passenger_capacity
      t.decimal :base_fare
      t.integer :shield_rating
      t.integer :armor_rating
      t.decimal :cargo_capacity

      t.timestamps
    end
  end
end
