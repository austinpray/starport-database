class CreateCargo < ActiveRecord::Migration[5.0]
  def change
    create_table :cargo do |t|
      t.integer :safefy_rating
      t.text :description
      t.references :person, foreign_key: true
      t.decimal :weight

      t.timestamps
    end
  end
end
