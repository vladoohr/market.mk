class ChangeLongLatPrecision < ActiveRecord::Migration
  def change
	change_column :advertisements, :latitude, :decimal, :precision => 16, :scale => 2
	change_column :advertisements, :longitude, :decimal, :precision => 16, :scale => 2
  end
end
