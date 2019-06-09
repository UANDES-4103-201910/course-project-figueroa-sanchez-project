class RemoveLocationFromAdminLocation < ActiveRecord::Migration[5.2]
  def change
    remove_column :admin_locations, :location, :string
  end
end
