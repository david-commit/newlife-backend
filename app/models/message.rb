class Message < ApplicationRecord
  belongs_to :appointment

  validates :appointment_id, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, presence: true
  validate :no_communication_outside_appointment

  def no_communication_outside_appointment
    appointment = Appointment.find_by(id: appointment_id)

    if([sender_id, receiver_id] != [appointment&.user_id, appointment&.practitioner_id].sort)
      errors.add(:invalid_communication, "sender and receiver should either be patient or practitioner pertaining to the given appointment")
    end
  end
end
