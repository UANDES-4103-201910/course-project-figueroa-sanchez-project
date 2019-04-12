class CreateAdminBlackLists < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_black_lists do |t|
      t.references :black_list, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
