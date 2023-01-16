class PatientProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :bio, :dob, :location, :blood_group, :height, :weight, :phone_number, :bmi, :email
  belongs_to :user
end
