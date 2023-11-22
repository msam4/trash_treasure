class AddCoordinatesToTrashBins < ActiveRecord::Migration[7.1]
  def change
    add_column :trash_bins, :latitude, :float
    add_column :trash_bins, :longitude, :float
  end
end
