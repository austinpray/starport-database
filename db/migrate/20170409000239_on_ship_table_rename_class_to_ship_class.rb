class OnShipTableRenameClassToShipClass < ActiveRecord::Migration[5.0]
  def change
    rename_column :ships, :class, :ship_class
  end
end
