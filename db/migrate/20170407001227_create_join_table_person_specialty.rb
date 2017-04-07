class CreateJoinTablePersonSpecialty < ActiveRecord::Migration[5.0]
  def change
    create_join_table :people, :specialties do |t|
      # t.index [:person_id, :specialty_id]
      # t.index [:specialty_id, :person_id]
    end
  end
end
