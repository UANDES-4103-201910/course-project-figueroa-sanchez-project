class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.references :category, foreign_key: true
      t.references :post, foreign_key: true
      t.string :link

      t.timestamps
    end
  end
end
