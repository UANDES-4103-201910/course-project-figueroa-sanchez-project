class AddLocationRefToAdminLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :admin_locations, :location, foreign_key: true
  end
end
