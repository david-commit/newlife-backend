require 'rails_helper'

RSpec.describe Appointment, type: :model do
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

    expect(appointment.id.nil?).to eql(false)
  end

  it "can have many messages" do
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

    expect(appointment.messages).to be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end

  it "is deleted when a the patient it belongs to is deleted" do
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
    
    appointment_id = appointment.id
    user.destroy

    expect{Appointment.find(appointment_id)}.to raise_error ActiveRecord::RecordNotFound
  end

  it "is deleted when a the practitioner it belongs to is deleted" do
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
    
    appointment_id = appointment.id
    practitioner.destroy

    expect{Appointment.find(appointment_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
