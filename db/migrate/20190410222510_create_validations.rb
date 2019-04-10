class CreateValidations < ActiveRecord::Migration[5.2]
  def change
    create_table :validations do |t|
      t.reference :user
      t.reference :post
      t.boolean :vote

      t.timestamps
    end
  end
end
