class DepartmentPractitionerSerializer < ActiveModel::Serializer
  attributes :id
  has_one :department
  has_one :practitioner
end
