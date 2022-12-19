require 'rails_helper'

RSpec.describe User, type: :model do
  it "can be created with valid inputs (must contain username, email, and password)" do
    User.destroy_all

    user = User.create!(
      username: Faker::Internet.username(specifier: 5..15),
      password: Faker::Internet.username,
      email: Faker::Internet.email
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
      username: Faker::Internet.username(specifier: 5..15),
      password: Faker::Internet.username,
      email: Faker::Internet.email
    )

    expect(user.appointments).to be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end
