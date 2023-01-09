class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :description_header, :description_content
  has_one :product
end
