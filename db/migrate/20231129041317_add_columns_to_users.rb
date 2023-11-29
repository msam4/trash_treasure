class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :place_counter, :integer
    add_column :users, :trash_bin_counter, :integer
    add_column :users, :distance, :integer
    add_column :users, :photo_counter, :integer
  end
end
