class CreateFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :facilities do |t|
      t.string :type
      t.references :ship, foreign_key: true
      t.references :parent_terminal, foreign_key: { to_table: :facilities }
      t.string :display_name
      t.string :slug

      t.timestamps
    end
  end
end
