class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :type
      t.string :state
      t.string :title
      t.string :description
      t.integer :price
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
