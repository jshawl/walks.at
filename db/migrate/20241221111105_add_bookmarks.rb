class AddBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.float :northeast_latitude
      t.float :northeast_longitude
      t.float :southwest_latitude
      t.float :southwest_longitude
      t.string :name
      t.belongs_to :user
      t.timestamps
    end
  end
end
