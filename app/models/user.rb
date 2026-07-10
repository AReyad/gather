# frozen_string_literal: true

class User < ApplicationRecord
  has_many :hosted_events, foreign_key: :host_id, class_name: "Event", dependent: :destroy
  has_many :event_attendings, foreign_key: :event_attendee_id, dependent: :destroy
  has_many :attending_events, through: :event_attendings, source: :attended_event

  validates :username, length: { in: 5..15 }, format: { with: /\A[a-zA-Z0-9]+\z/,
                                                        message: "only allows letters and numbers." }, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.downcase.strip }
  normalizes :username, with: ->(username) { username.downcase.strip }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
