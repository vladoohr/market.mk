class AddPictureToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :picture, :string
  end
end
