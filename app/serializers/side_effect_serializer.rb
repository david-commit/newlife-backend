class SideEffectSerializer < ActiveModel::Serializer
  attributes :id, :side_effect
  has_one :product
end
