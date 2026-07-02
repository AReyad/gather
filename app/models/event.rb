class Event < ApplicationRecord
  validates :title, presence: true, length: { in: 10..50 }
  validates :description, presence: true, length: { in: 50..500 }
  belongs_to :event_host, class_name: "User"
end
