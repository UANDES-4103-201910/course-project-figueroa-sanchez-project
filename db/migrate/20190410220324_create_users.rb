class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :mail
      t.boolean :is_active

      t.timestamps
    end
  end
end
