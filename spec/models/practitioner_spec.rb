require 'rails_helper'

RSpec.describe Practitioner, type: :model do
  it "can be created with valid inputs (must contain username, email, and password)" do
    Practitioner.destroy_all
    user = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    expect(user.id.nil?).to eql(false)
  end

  it "cannot be created with invalid inputs (one of username, email, or password is missing)" do
    Practitioner.destroy_all
    expect{Practitioner.create!()}.to raise_error ActiveRecord::RecordInvalid  
  end

  it "can have appointments" do
    Practitioner.destroy_all

    user = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    expect(user.appointments).to be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end
