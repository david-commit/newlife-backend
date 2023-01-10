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

    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.find_by(username: "what")&.destroy_all
    Practitioner.find_by(email: "email")&.destroy_all

    post '/practitioner/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com", "department_id": department.id}

    token = JSON.parse(response.body)["jwt"]
    practitioner = Practitioner.find_by(email: "what@what.com")
    
    post "/appointments",
    params: {
      "user_id": user.id,
      "practitioner_id": practitioner.id,
      "date": "2022-12-21",
      "approved": false,
      "appointment_type": "Normal" 
    },
    headers: {
      "Accept": "application/json",
      "Authorization": token
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
    post '/practitioner/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com", "department_id": department.id}

    token = JSON.parse(response.body)["jwt"]
    practitioner = Practitioner.find_by(email: "what@what.com")   
    
    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )
    
    patch "/appointments/#{appointment.id}", params: {"approved": true}, headers: {"Accept": "application/json", "Authorization": token}

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
    post '/practitioner/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com", "department_id": department.id}

    token = JSON.parse(response.body)["jwt"]
    practitioner = Practitioner.find_by(email: "what@what.com")   
    
    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )
    
    delete "/appointments/#{appointment.id}", params: {"approved": true}, headers: {"Accept": "application/json", "Authorization": token}

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
    post '/practitioner/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com", "department_id": department.id}

    token = JSON.parse(response.body)["jwt"]
    practitioner = Practitioner.find_by(email: "what@what.com")   

    post '/practitioner/signup', params: {"username": "enock", "password": "Passw0rd3", "email": "enock@enock.com", "department_id": department.id}

    token2 = JSON.parse(response.body)["jwt"]
    practitioner2 = Practitioner.find_by(email: "enock@enock.com")   
    
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
    get "/users/#{user.id}/appointments", headers: {"Accept": "application/json", "Authorization": token}

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
    post '/practitioner/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com", "department_id": department.id}

    token = JSON.parse(response.body)["jwt"]
    practitioner = Practitioner.find_by(email: "what@what.com")   

    post '/practitioner/signup', params: {"username": "enock", "password": "Passw0rd3", "email": "enock@enock.com", "department_id": department.id}

    token2 = JSON.parse(response.body)["jwt"]
    practitioner2 = Practitioner.find_by(email: "enock@enock.com")      
    
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
    
    get "/practitioners/#{practitioner2.id}/appointments", headers: {"Accept": "application/json", "Authorization": token}

    expect(JSON.parse(response.body).length).to eql(1)    
  end
end
