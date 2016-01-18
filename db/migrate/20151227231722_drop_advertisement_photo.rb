class DropAdvertisementPhoto < ActiveRecord::Migration
  def change
  	drop_table :advertisement_photos
  end
end
