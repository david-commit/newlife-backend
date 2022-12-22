class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :practitioners
end
