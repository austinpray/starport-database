class CreateCrewSlotAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :crew_slot_assignments do |t|
      t.references :person, foreign_key: true
      t.references :ship, foreign_key: true
      t.references :crew_slot, foreign_key: true

      t.timestamps
    end
  end
end
