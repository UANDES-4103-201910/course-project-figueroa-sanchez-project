class CreateProfileLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_locations do |t|
      t.references :profile
      t.string :location

      t.timestamps
    end
  end
end
