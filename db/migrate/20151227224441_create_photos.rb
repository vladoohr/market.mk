class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.references :advertisement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
