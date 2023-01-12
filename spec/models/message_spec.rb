require 'rails_helper'

RSpec.describe Message, type: :model do

  it "can be created using valid inputs" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Department.destroy_all
    department = Department.create!(name: "Human Resource")    

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
      practitioner_id: practitioner.id,
      appointment_info: "blah blah blah"
    )

    Message.destroy_all
    message = Message.create!(
      appointment_id: appointment.id,
      sender_id: user.id,
      sender_class: user.class.to_s,
      receiver_id: practitioner.id,
      receiver_class: practitioner.class.to_s,
      content: "Hey, I would like to have an appointment with you this week. When do I expect you to be free?"
    )

    expect(message.id.nil?).to eql(false)
  end

  it "cannot be created with invalid input" do
    expect{Message.create!()}.to raise_error ActiveRecord::RecordInvalid
  end

  it "has correct content when created" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Department.destroy_all
    department = Department.create!(name: "Human Resource")

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
      practitioner_id: practitioner.id,
      appointment_info: "blah blah blah"
    )

    Message.destroy_all
    message = Message.create!(
      appointment_id: appointment.id,
      sender_id: user.id,
      sender_class: user.class.to_s,
      receiver_id: practitioner.id,
      receiver_class: practitioner.class.to_s,
      content: "Hey, I would like to have an appointment with you this week. When do I expect you to be free?"
    )
    
    expect(message.content).to eql("Hey, I would like to have an appointment with you this week. When do I expect you to be free?")
  end

  it "is deleted when the appointment it belongs to is deleted" do 
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Department.destroy_all
    department = Department.create!(name: "Human Resource")

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
      practitioner_id: practitioner.id,
      appointment_info: "blah blah blah"
    )

    Message.destroy_all
    message = Message.create!(
      appointment_id: appointment.id,
      sender_id: user.id,
      sender_class: user.class.to_s,
      receiver_id: practitioner.id,
      receiver_class: practitioner.class.to_s,
      content: "Hey, I would like to have an appointment with you this week. When do I expect you to be free?"
    )

    message_id = message.id
    appointment.destroy

    expect{Message.find(message_id)}.to raise_error ActiveRecord::RecordNotFound
  end        
end
