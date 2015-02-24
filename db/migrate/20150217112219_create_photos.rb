class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :portfolio
      t.string :title
      t.string :flickr_id, :secret
      t.string :medium_url
      t.string :large_url
      t.boolean :visible, :default => true
      t.timestamps null: false
    end
  end
end
