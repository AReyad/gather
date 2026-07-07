class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :event_attendings, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendings, source: :event_attendee

  validates :title, presence: true, length: { in: EventValidations::MIN_TITLE_LENGTH..EventValidations::MIN_TITLE_LENGTH }
  validates :description, presence: true, length: { in: EventValidations::MIN_DESCRIPTION_LENGTH..EventValidations::MIN_DESCRIPTION_LENGTH }
  validates :location, presence: true, length: { in: EventValidations::MIN_LOCATION_LENGTH ..EventValidations::MIN_LOCATION_LENGTH  }
  validates :date, presence: true
  validates :date, comparison: { greater_than_or_equal_to: EventValidations.min_date, message: "must be greater than today e.g. #{EventValidations.min_date}" }
  validates :date, comparison: { less_than_or_equal_to: EventValidations.max_date, message: "must be less than 80 years from now" }
  validates :time, presence: true, format: { with: /\d{2}:\d{2}/, message: "must be valid time e.g. 12:00" }

  enum :privacy, [ :public, :private ], default: :public, suffix: :event

  default_scope { order(created_at: :desc) }
  scope :past, -> { where("date < ?", Date.today) || where("date == ?", Date.today).and(where("time < ?", Time.current.strftime("%H:%M"))) }
  scope :upcoming, -> { where("date > ?", Date.today) || where("date >= ?", Date.today).and(where("time > ?", Time.current.strftime("%H:%M"))) }
end
