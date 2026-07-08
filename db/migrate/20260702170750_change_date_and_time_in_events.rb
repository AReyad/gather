# frozen_string_literal: true

class ChangeDateAndTimeInEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :event_date, :date
    rename_column :events, :event_time, :time
  end
end
