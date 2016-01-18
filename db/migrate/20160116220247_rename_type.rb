class RenameType < ActiveRecord::Migration
  def change
  	rename_column :advertisements, :type, :advert_type
  end
end
