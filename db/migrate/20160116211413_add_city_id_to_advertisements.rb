class AddCityIdToAdvertisements < ActiveRecord::Migration
  def change
	add_column :advertisements, :city_id, :integer
  end
end
