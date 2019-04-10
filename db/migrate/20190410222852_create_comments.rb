class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.reference :user
      t.reference :post
      t.text :comment

      t.timestamps
    end
  end
end
