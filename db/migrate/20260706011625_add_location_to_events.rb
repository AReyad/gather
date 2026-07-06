class AddLocationToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :location, :string
  end
end
