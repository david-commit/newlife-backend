class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :approved, :appointment_type, :appointment_info
  belongs_to :user
  belongs_to :practitioner
end
