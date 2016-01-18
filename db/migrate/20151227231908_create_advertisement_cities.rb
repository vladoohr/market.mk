class CreateAdvertisementCities < ActiveRecord::Migration
  def change
    create_table :advertisement_cities do |t|
      t.integer :advertisement_id
      t.integer :city_id

      t.timestamps null: false
    end
  end
end
