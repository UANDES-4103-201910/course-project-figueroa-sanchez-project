class RemoveLocationFromPostLocation < ActiveRecord::Migration[5.2]
  def change
    remove_reference :post_locations, :location, foreign_key: true
  end
end
