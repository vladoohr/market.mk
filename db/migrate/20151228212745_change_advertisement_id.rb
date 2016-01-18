class ChangeAdvertisementId < ActiveRecord::Migration
  def change
  	rename_column :advertisement_cities, :advertiement_id, :advertisement_id
  end
end
