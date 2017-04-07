class CreateCrewSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :crew_slots do |t|
      t.string :name
      t.text :description
      t.references :specialty, foreign_key: true

      t.timestamps
    end
  end
end
