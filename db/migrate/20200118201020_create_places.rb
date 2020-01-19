class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.datetime :created_at
      t.float :latitude
      t.float :longitude
      t.string :name
    end
  end
end
