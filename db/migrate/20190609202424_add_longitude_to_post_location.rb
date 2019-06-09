class AddLongitudeToPostLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :post_locations, :longitude, :float
  end
end
