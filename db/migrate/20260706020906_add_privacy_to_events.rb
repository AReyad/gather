class AddPrivacyToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :privacy, :integer, default: 0
  end
end
