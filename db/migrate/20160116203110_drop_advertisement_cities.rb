class DropAdvertisementCities < ActiveRecord::Migration
  def change
  	drop_table :advertisement_cities
  end
end
