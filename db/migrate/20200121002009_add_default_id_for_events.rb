class AddDefaultIdForEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :user_id, :integer, default: 1
  end
end
