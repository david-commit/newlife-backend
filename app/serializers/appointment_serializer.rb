class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :approved, :appointment_type, :appointment_info, :time
  belongs_to :user
  belongs_to :practitioner
  has_many :messages
end
