require 'rails_helper'

RSpec.describe "Appointments", type: :request do

  it "can be created" do

    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com",
      department_id: department.id
    )    

    headers = {"Content-Type": "application/json", "Accept": "application/json"}

    post "/appointments", params: {
      "user_id": user.id,
      "practitioner_id": practitioner.id,
      "date": "2022-12-21",
      "approved": false,
      "appointment_type": "Normal"
    }

    expect(response).to have_http_status(201)
  end

  it "can be updated" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com",
      department_id: department.id
    )    
    
    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )
    
    headers = {"Content-Type": "application/json"}

    patch "/appointments/#{appointment.id}", params: {"approved": true}

    expect(JSON.parse(response.body)["approved"]).to eql(true)
  end

  it "can be destroyed" do
     User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com",
      department_id: department.id
    )    
    
    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )
    
    headers = {"Content-Type": "application/json"}

    delete "/appointments/#{appointment.id}", params: {"approved": true}

    expect(response).to have_http_status(:no_content)    
  end

  it "can be viewed in the context of a user" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    user2 = User.create!(
      username: "enock",
      password: "Passw0rd3",
      email: "enock@enock.com"
    )    

    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com",
      department_id: department.id
    )  
    
   practitioner2 = Practitioner.create!(
      username: "enock",
      password: "Passw0rd3",
      email: "enock@enock.com",
      department_id: department.id
    )     
    
    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )

    appointment2 = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )
    
    appointment2 = Appointment.create!(
      user_id: user2.id,
      practitioner_id: practitioner.id
    ) 
    
    headers = {"Accept": "application/json"}
    get "/users/#{user.id}/appointments"

    expect(JSON.parse(response.body).length).to eql(2)
  end

  it "can be viewed in the context of a practitioner" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    user2 = User.create!(
      username: "enock",
      password: "Passw0rd3",
      email: "enock@enock.com"
    )    

    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com",
      department_id: department.id
    )  
    
   practitioner2 = Practitioner.create!(
      username: "enock",
      password: "Passw0rd3",
      email: "enock@enock.com",
      department_id: department.id
    )     
    
    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )

    appointment2 = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner2.id
    )
    
    appointment2 = Appointment.create!(
      user_id: user2.id,
      practitioner_id: practitioner.id
    ) 
    
    headers = {"Accept": "application/json"}
    get "/practitioners/#{practitioner2.id}/appointments"

    expect(JSON.parse(response.body).length).to eql(1)    
  end
end
