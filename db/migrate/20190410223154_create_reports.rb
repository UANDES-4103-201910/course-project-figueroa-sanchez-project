class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.reference :user
      t.reference :post
      t.reference :report_category
      t.text :comment

      t.timestamps
    end
  end
end
