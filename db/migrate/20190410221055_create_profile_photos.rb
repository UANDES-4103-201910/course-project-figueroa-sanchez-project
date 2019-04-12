class CreateProfilePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_photos do |t|
      t.references :profile
      t.string :photo_link

      t.timestamps
    end
  end
end
