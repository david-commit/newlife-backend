class OrderSerializer < ActiveModel::Serializer
  attributes :id, :delivered
  belongs_to :user
  has_one :payment
end
