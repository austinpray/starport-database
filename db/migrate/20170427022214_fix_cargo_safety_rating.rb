class FixCargoSafetyRating < ActiveRecord::Migration[5.0]
  def change
    rename_column :cargo, :safefy_rating, :safety_rating
  end
end
