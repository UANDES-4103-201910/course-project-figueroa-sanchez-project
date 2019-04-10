class CreateAdminLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_locations do |t|
      t.reference :user
      t.string :location

      t.timestamps
    end
  end
end
