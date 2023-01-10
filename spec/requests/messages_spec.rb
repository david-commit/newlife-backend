require 'rails_helper'

RSpec.describe "Messages", type: :request do
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

    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )

    headers = {"ContentType": "application/json"}
    post '/messages', params: {
        "content": "Message 1",
        "sender_id": 1,
        "receiver_id": 1,
        "sender_class": "Practitioner",
        "receiver_class": "User",
        "appointment_id": appointment.id 
    }

    expect(response).to have_http_status(201)
  end

  it "can be viewed (1) Returns an array" do
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

    Message.destroy_all
    headers = {"ContentType": "application/json"}
    post '/messages', params: {
      "content": "Message 1",
      "sender_id": 1,
      "receiver_id": 1,
      "sender_class": "Practitioner",
      "receiver_class": "User",
      "appointment_id": appointment.id 
    }

    post '/messages', params: {
      "content": "Message 2",
      "sender_id": 1,
      "receiver_id": 1,
      "sender_class": "Practitioner",
      "receiver_class": "User",
      "appointment_id": appointment.id 
    }

    get "/users/#{user.id}/appointments/#{appointment.id}/messages"

    expect(JSON.parse(response.body)).to be_kind_of(Array)
  end

  it "can be viewed only in the context of a particular user and appointment" do
    User.destroy_all
    user1 = User.create!(
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
    practitioner1 = Practitioner.create!(
      username: "vince",
      password: "vince",
      email: "vincent@practitioner.com",
      department_id: department.id
    )

    practitioner2 = Practitioner.create!(
      username: "mokua",
      password: "mokua",
      email: "mokua@practitioner.com",
      department_id: department.id
    )    

    Appointment.destroy_all
    appointment1 = Appointment.create!(
      user_id: user1.id,
      practitioner_id: practitioner1.id
    )

    appointment2 = Appointment.create!(
      user_id: user1.id,
      practitioner_id: practitioner2.id
    )
    
    appointment3 = Appointment.create!(
      user_id: user2.id,
      practitioner_id: practitioner2.id
    )    

    Message.destroy_all
    headers = {"ContentType": "application/json"}
    post '/messages', params: {
      "content": "Message 1",
      "sender_id": user1.id,
      "receiver_id": practitioner1.id,
      "sender_class": "Practitioner",
      "receiver_class": "User",
      "appointment_id": appointment1.id 
    }

    post '/messages', params: {
      "content": "Message 2",
      "sender_id": user1.id,
      "receiver_id": practitioner2.id,
      "sender_class": "Practitioner",
      "receiver_class": "User",
      "appointment_id": appointment2.id 
    }

    post '/messages', params: {
      "content": "Message 3",
      "sender_id": user2.id,
      "receiver_id": practitioner2.id,
      "sender_class": "Practitioner",
      "receiver_class": "User",
      "appointment_id": appointment3.id 
    }    

    get "/users/#{user1.id}/appointments/#{appointment1.id}/messages"

    expect(JSON.parse(response.body).length).to eql(1)
  end  
end
