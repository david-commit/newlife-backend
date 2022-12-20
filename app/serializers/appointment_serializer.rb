class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :approved, :appointment_type
  has_one :user
  has_one :practitioner
end
