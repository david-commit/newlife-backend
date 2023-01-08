class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :price, :image, :quantity, :stock, :rating, :description, :dosage, :effects
end
