# frozen_string_literal: true

class EventAttending < ApplicationRecord
  belongs_to :event_attendee, class_name: "User"
  belongs_to :attended_event, class_name: "Event"
  validates :event_attendee_id,
            uniqueness: { scope: :attended_event_id, message: "You are already attending this event" }
end
