class ShoppingCartSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :product_id, :quantity
end
