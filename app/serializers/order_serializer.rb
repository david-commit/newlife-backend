class OrderSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :payment
end
