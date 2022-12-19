class Message < ApplicationRecord
  belongs_to :appointment

  validates :appointment_id, presence: true
end
