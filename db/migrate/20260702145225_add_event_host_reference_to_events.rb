class AddEventHostReferenceToEvents < ActiveRecord::Migration[8.1]
  def change
    add_reference :events, :event_host, null: false, foreign_key: { to_table: :users }
  end
end
