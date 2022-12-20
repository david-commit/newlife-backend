class MessageSerializer < ActiveModel::Serializer
  attributes :id
  has_one :appointment
end
