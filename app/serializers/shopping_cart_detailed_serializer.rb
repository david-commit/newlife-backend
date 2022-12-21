class ShoppingCartDetailedSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :product_id
  belongs_to :order
  belongs_to :product
end
