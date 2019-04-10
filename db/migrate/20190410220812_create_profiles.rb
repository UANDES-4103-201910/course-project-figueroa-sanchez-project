class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.reference :user
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
