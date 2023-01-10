class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :price, :description, :image, :dosage, :stock

  has_many :dosage_considerations
  has_many :side_effects
  has_many :reviews
end
