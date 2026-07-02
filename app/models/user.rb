class User < ApplicationRecord
  has_many :hosted_events, foreign_key: :host_id, class_name: "Event"

  validates :username, length: { in: 5..15 }, presence: true, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
