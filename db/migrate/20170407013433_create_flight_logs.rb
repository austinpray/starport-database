class CreateFlightLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :flight_logs do |t|
      t.references :trip, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
