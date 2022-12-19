require 'rails_helper'

RSpec.describe Message, type: :model do

  it "can be created using valid inputs" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )

    Message.destroy_all
    message = Message.create(
      appointment_id: appointment.id
    )

    expect(message.id.nil?).to eql(false)
  end

  it "is deleted when the appointment it belongs to is deleted" do 
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Appointment.destroy_all
    appointment = Appointment.create!(
      user_id: user.id,
      practitioner_id: practitioner.id
    )

    Message.destroy_all
    message = Message.create(
      appointment_id: appointment.id
    )

    message_id = message.id
    appointment.destroy

    expect{Message.find(message_id)}.to raise_error ActiveRecord::RecordNotFound
  end        
end
