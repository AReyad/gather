# frozen_string_literal: true

class AddColumnsToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :title, :string
    add_column :events, :description, :string
  end
end
