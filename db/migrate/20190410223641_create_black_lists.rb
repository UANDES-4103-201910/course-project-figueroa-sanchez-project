class CreateBlackLists < ActiveRecord::Migration[5.2]
  def change
    create_table :black_lists do |t|
      t.reference :user

      t.timestamps
    end
  end
end
