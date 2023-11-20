class CreateTosses < ActiveRecord::Migration[7.1]
  def change
    create_table :tosses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trash_bin, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
