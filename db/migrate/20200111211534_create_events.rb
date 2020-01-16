class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :created_at
      t.float :latitude
      t.float :longitude
    end
  end
end
