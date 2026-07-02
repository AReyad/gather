class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, length: { in: 5..15 }, presence: true, uniqueness: true
  has_many :hosted_events, foreign_key: "event_host_id", class_name: "Event"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
