require 'rails_helper'

RSpec.describe "PatientProfiles", type: :request do
  it "can be created" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    headers = {"Content-Type": "application/json"}

    post "/patient_profiles", params: {"user_id": user.id, "first_name": "vincent", "last_name": "vincent"}

    expect(response).to have_http_status(201)
  end

  it "can be updated" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    PatientProfile.destroy_all
    patient_profile = PatientProfile.create!(
      user_id: user.id,
      first_name: "Vincent",
      last_name: "Vincent"
    ) 
    
    patch "/patient_profiles/#{patient_profile.id}", params: {"height": 1000000}

    expect(JSON.parse(response.body)["height"]).to eql(1000000.to_f)
  end

  it "can be viewed singly" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    PatientProfile.destroy_all
    patient_profile = PatientProfile.create!(
      user_id: user.id,
      first_name: "Vincent",
      last_name: "Vincent"
    ) 
    
    get "/patient_profiles/#{patient_profile.id}"

    expect(JSON.parse(response.body)).to be_kind_of(Hash)    
  end

  it "can be viewed wholly (all profiles, that is)" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )
    
    get "/patient_profiles"

    expect(JSON.parse(response.body)).to be_kind_of(Array)    
  end 
  
  it "can be destroyed" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    PatientProfile.destroy_all
    patient_profile = PatientProfile.create!(
      user_id: user.id,
      first_name: "Vincent",
      last_name: "Vincent"
    ) 
    
    delete "/patient_profiles/#{patient_profile.id}"  
    
    expect(response).to have_http_status(:no_content)
  end
end
