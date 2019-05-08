class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user
      t.string :title
      t.text :description
      t.boolean :solved

      t.timestamps
    end
  end
end
