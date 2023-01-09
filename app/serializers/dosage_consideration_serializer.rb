class DosageConsiderationSerializer < ActiveModel::Serializer
  attributes :id, :consideration
  has_one :product
end
