class AddLocationRefToPostLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :post_locations, :location, foreign_key: true
  end
end
