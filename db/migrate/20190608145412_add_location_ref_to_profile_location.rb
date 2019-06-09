class AddLocationRefToProfileLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :profile_locations, :location, foreign_key: true
  end
end
