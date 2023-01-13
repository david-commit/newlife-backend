class PractitionerProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :bio, :dob, :phone_number, :location, :blood_group, :weight, :bmi, :email
  belongs_to :practitioner
end
