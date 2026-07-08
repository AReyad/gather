# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.date :event_date
      t.time :event_time
      t.timestamps
    end
  end
end
