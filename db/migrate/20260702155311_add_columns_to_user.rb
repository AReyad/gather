# frozen_string_literal: true

class AddColumnsToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :username, :string
  end
end
