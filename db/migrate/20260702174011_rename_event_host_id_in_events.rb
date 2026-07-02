class RenameEventHostIdInEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :event_host_id, :host_id
  end
end
