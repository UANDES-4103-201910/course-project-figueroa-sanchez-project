class CreateSharedPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_posts do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
  end
end
