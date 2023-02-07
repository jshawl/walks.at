# frozen_string_literal: true

class AddAttributesToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :speed, :integer
    add_column :events, :direction, :integer
    add_column :events, :accuracy, :integer
  end
end
