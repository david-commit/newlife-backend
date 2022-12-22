class PractitionerSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  has_many :appointments
  has_many :practitioner_profiles
end
