require 'rails_helper'

RSpec.describe "PractitionerProfiles", type: :request do
  it "can be created" do
    Department.destroy_all
    department = Department.create(name: "Department 1")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    headers = {"Content-Type": "application/json"}

    post "/practitioner_profiles", params: {"practitioner_id": practitioner.id, "first_name": "vincent", "last_name": "vincent"}

    expect(response).to have_http_status(201)
  end

  it "can be updated" do
    Department.destroy_all
    department = Department.create(name: "Department 1")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    PractitionerProfile.destroy_all
    patient_profile = PractitionerProfile.create!(
      practitioner_id: practitioner.id,
      first_name: "Vincent",
      last_name: "Vincent"
    ) 
    
    patch "/practitioner_profiles/#{patient_profile.id}", params: {"weight": 1000000}

    expect(JSON.parse(response.body)["weight"]).to eql(1000000.to_f)
  end

  it "can be viewed singly" do
    Department.destroy_all
    department = Department.create(name: "Department 1")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    PractitionerProfile.destroy_all
    patient_profile = PractitionerProfile.create!(
      practitioner_id: practitioner.id,
      first_name: "Vincent",
      last_name: "Vincent"
    ) 
    
    get "/practitioner_profiles/#{patient_profile.id}"

    expect(JSON.parse(response.body)).to be_kind_of(Hash)    
  end

  it "can be viewed wholly (all profiles, that is)" do
    Department.destroy_all
    department = Department.create(name: "Department 1")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )
    
    get "/practitioner_profiles"

    expect(JSON.parse(response.body)).to be_kind_of(Array)    
  end 
  
  it "can be destroyed" do
    Department.destroy_all
    department = Department.create(name: "Department 1")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    PractitionerProfile.destroy_all
    patient_profile = PractitionerProfile.create!(
      practitioner_id: practitioner.id,
      first_name: "Vincent",
      last_name: "Vincent"
    ) 
    
    delete "/practitioner_profiles/#{patient_profile.id}"  
    
    expect(response).to have_http_status(:no_content)
  end
end
