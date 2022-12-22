class Message < ApplicationRecord
  belongs_to :appointment

  validates :appointment_id, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, presence: true
  validates :sender_class, presence: true, inclusion: {in: ["Practitioner", "User"]}
  validates :receiver_class, presence: true, inclusion: {in: ["Practitioner", "User"]}
  validate :no_communication_outside_appointment

  def no_communication_outside_appointment
    if(sender_class == receiver_class || !user_has_this_appointment || !practitioner_has_this_appointment)
      errors.add(:invalid_communication, "sender and receiver should either be patient or practitioner pertaining to the given appointment")
    end
  end

  private
  def user_has_this_appointment
    appointment = Appointment.find_by(id: appointment_id)
    user_appointments = User.find_by(id: appointment&.user_id)&.appointments
    return !user_appointments&.find {|appointment| appointment["user_id"] == appointment&.user_id}.nil?
  end

  def practitioner_has_this_appointment
    appointment = Appointment.find_by(id: appointment_id)
    practitioner_appointments = Practitioner.find_by(id: appointment&.practitioner_id)&.appointments
    return !practitioner_appointments&.find {|appointment| appointment["practitioner_id"] == appointment&.practitioner_id}.nil?
  end
end
