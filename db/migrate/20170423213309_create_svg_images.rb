class CreateSvgImages < ActiveRecord::Migration[5.0]
  def change
    create_table :svg_images do |t|
      t.text :data
      t.string :name
      t.string :source

      t.timestamps
    end

    add_column :ships, :svg_image_id, :integer
    add_foreign_key :ships, :svg_images

    add_index :svg_images, :name, unique: true
  end
end
