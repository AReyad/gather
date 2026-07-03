class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :event_attendings, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendings, source: :event_attendee

  validates :title, presence: true, length: { in: 10..50 }
  validates :description, presence: true, length: { in: 50..500 }
  validates :date, presence: true
  validates :date, comparison: { greater_than: Date.today, message: "must be greater than today e.g. #{Date.today + 1.day}" }
  validates :time, presence: true, format: { with: /\d{2}:\d{2}/, message: "must be valid time e.g. 12:00" }
end
