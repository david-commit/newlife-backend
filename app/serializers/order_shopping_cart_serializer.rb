class OrderShoppingCartSerializer < ActiveModel::Serializer
  attributes :id, :delivered
  belongs_to :user
  has_one :payment
  has_many :products
end
