class RemoveLocationFromProfileLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :profile_locations, :location, :string
  end
end
