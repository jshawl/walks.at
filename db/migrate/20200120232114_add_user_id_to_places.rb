# frozen_string_literal: true

class AddUserIdToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :places, :user, null: false, foreign_key: true, default: 1
  end
end
