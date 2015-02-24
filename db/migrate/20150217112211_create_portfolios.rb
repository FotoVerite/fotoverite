class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :title
      t.string :flickr_id, :secret, :primary_photo_id
      t.string :medium_url
      t.boolean :visible, :default => true
      t.timestamps null: false
      t.string :slug
    end
      add_index :portfolios, :slug, unique: true
  end
end
