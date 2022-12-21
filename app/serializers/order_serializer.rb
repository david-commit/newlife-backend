class OrderSerializer < ActiveModel::Serializer
  attributes :id, :delivered
  has_one :user
  has_one :payment
end
