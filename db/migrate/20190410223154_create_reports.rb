class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :user
      t.references :post
      t.references :report_category
      t.text :comment

      t.timestamps
    end
  end
end
