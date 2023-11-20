class CreateTrashBins < ActiveRecord::Migration[7.1]
  def change
    create_table :trash_bins do |t|
      t.string :category
      t.integer :capacity
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end
