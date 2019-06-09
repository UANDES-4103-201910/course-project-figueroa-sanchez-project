class AddLatitudeToPostLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :post_locations, :latitude, :float
  end
end
