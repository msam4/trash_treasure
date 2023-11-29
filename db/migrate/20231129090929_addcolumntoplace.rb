class Addcolumntoplace < ActiveRecord::Migration[7.1]
  def change
    add_reference :places, :user, index: true
    add_reference :trash_bins, :user, index: true
  end
end
