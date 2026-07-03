class CreateEventAttendings < ActiveRecord::Migration[8.1]
  def change
    create_table :event_attendings do |t|
      t.belongs_to :event_attendee
      t.belongs_to :attended_event
      t.timestamps
    end
  end
end
