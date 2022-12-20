class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :practitioner
  has_many :messages, dependent: :destroy

  validates :user, presence: true
  validates :practitioner, presence: true
end
