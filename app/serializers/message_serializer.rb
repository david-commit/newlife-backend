class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :sender_id, :receiver_id, :sender_class, :receiver_class, :created_at, :updated_at
  has_one :appointment
end
