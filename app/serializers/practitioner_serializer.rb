class PractitionerSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :first_name, :last_name, :department
  has_many :appointments
  has_many :practitioner_profiles
  belongs_to :department

  def first_name
    PractitionerProfile.find_by(id: self.object.id)&.first_name
  end

  def last_name
    PractitionerProfile.find_by(id: self.object.id)&.last_name
  end
end
