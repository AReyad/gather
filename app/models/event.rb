# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :event_attendings, -> { order(created_at: :asc) }, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendings, source: :event_attendee

  validates :title, presence: true, length: { in: EventValidations::MIN_TITLE_LENGTH..EventValidations::MAX_TITLE_LENGTH }
  validates :description, presence: true, length: { in: EventValidations::MIN_DESCRIPTION_LENGTH..EventValidations::MAX_DESCRIPTION_LENGTH }
  validates :location, presence: true, length: { in: EventValidations::MIN_LOCATION_LENGTH..EventValidations::MAX_LOCATION_LENGTH }
  validates :date, presence: true
  validates :date,
            comparison: { greater_than_or_equal_to: EventValidations.min_date,
                          message: "must be greater than today e.g. #{EventValidations.min_date}" }
  validates :date,
            comparison: { less_than_or_equal_to: EventValidations.max_date,
                          message: "must be less than #{EventValidations.max_date} years from now" }
  validates :time, presence: true, format: { with: /\d{2}:\d{2}/, message: "must be valid time e.g. 12:00" }

  enum :privacy, { public: 0, private: 1 }, default: :public, suffix: :event

  default_scope { order(created_at: :desc) }
  scope :past, lambda {
    where(date: ...Time.zone.today).or(where(date: Time.zone.today).and(where(time: ...Time.zone.now.strftime("%H:%M"))))
  }
  scope :upcoming, lambda {
    where("date > ?", Time.zone.today).or(where(date: Time.zone.today).and(where("time > ?", Time.zone.now.strftime("%H:%M"))))
  }

  def past?
     date < Time.zone.today || (date == Time.zone.today && time < Time.zone.now.strftime("%H:%M"))
  end
end
