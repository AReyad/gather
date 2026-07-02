class Event < ApplicationRecord
  belongs_to :host, class_name: "User"

  validates :title, presence: true, length: { in: 10..50 }
  validates :description, presence: true, length: { in: 50..500 }
  validates :date, presence: true
  validates :date, comparison: { greater_than: Date.today, message: "must be greater than today e.g. #{Date.today + 1.day}" }
  validates :time, presence: true
end
