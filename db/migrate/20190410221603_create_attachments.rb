class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.reference :category
      t.string :link

      t.timestamps
    end
  end
end
