class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :first_name, :last_name

  has_many :orders
  has_many :appointments
  has_many :patient_profiles

  def first_name
    PractitionerProfile.find_by(id: self.object.id)&.first_name
  end

  def last_name
    PractitionerProfile.find_by(id: self.object.id)&.last_name
  end
end
