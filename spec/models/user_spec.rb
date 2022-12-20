require 'rails_helper'

RSpec.describe User, type: :model do
  it "can be created with valid inputs (must contain username, email, and password)" do
    User.destroy_all

    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    expect(user.id.nil?).to eql(false)
    
  end

  it "cannot be created with invalid inputs (one of username, email, or password is missing)" do
    User.destroy_all

    expect{
        User.create!(
        username: "",
        password: "",
        email: ""
      )
    }.to raise_error ActiveRecord::RecordInvalid  
  end

  it "can have appointments" do
    User.destroy_all

    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    expect(user.appointments).to be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end
