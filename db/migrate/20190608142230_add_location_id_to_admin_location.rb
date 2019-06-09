class AddLocationIdToAdminLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_locations, :location_id, :string
  end
end
