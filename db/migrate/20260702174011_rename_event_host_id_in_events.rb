# frozen_string_literal: true

class RenameEventHostIdInEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :event_host_id, :host_id
    change_column :events, :time, :string
  end
end
