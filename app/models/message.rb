class Message < ApplicationRecord
  belongs_to :appointment

  validates :appointment_id, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, presence: true
end
