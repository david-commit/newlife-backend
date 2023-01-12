class PractitionerSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  has_many :appointments
  has_many :practitioner_profiles
  belongs_to :department
end
