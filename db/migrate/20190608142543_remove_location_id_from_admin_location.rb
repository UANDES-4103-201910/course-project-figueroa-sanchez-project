class RemoveLocationIdFromAdminLocation < ActiveRecord::Migration[5.2]
  def change
    remove_column :admin_locations, :location_id, :string
  end
end
