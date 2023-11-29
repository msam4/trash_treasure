class AddFullToTrashBin < ActiveRecord::Migration[7.1]
  def change
    add_column :trash_bins, :full, :boolean, default: false
  end
end
