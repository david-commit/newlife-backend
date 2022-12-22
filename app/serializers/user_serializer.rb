class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  has_many :orders
  has_many :appointments
  has_many :patient_profiles
end
