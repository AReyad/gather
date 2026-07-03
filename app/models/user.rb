class User < ApplicationRecord
  has_many :hosted_events, foreign_key: :host_id, class_name: "Event", dependent: :destroy

  validates :username, length: { in: 5..15 }, format: { with: /\A[a-zA-Z-0-9]+\z/,
    message: "only allows letters and numbers e.g. username123" },  presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.downcase.strip }
  normalizes :username, with: ->(username) { username.downcase.strip }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
