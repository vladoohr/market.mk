class RemovePictureFromAdvertisement < ActiveRecord::Migration
  def change
  	remove_column :advertisements, :picture, :string
  end
end
