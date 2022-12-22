require 'rails_helper'

RSpec.describe PatientProfile, type: :model do
  it "can be created with valid data" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    PatientProfile.destroy_all
    patient_profile = PatientProfile.create!(
      user_id: user.id,
      first_name: "Vincent",
      last_name: "Vincent"
    )

    expect(patient_profile.id.nil?).to eql(false)
  end

  it "cannot be created with invalid data" do
    expect{PatientProfile.create!()}.to raise_error ActiveRecord::RecordInvalid
  end

  it "is available in the User model it belongs to" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    PatientProfile.destroy_all
    patient_profile = PatientProfile.create!(
      user_id: user.id,
      first_name: "Vincent",
      last_name: "Vincent"
    )

    expect(user.patient_profile).to be_instance_of(PatientProfile)
  end

  it "is deleted when the user it belongs to is deleted" do 
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    PatientProfile.destroy_all
    patient_profile = PatientProfile.create!(
      user_id: user.id,
      first_name: "Vincent",
      last_name: "Vincent"
    )

    patient_profile_id = patient_profile.id
    user.destroy

    expect{PatientProfile.find(patient_profile_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
