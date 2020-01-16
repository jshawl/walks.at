class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :created_at
      t.latitude :float
      t.longitude :float
    end
  end
end
