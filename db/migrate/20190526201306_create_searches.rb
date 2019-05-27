class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :keywords
      t.boolean :profile
      t.boolean :location
      t.references :user

      t.timestamps
    end
  end
end
