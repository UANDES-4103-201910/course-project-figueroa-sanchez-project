class CreatePostLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :post_locations do |t|
      t.references :post, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
