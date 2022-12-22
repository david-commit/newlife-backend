require 'rails_helper'

RSpec.describe Practitioner, type: :model do
  it "can be created with valid inputs (must contain username, email, and password)" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    expect(practitioner.id.nil?).to eql(false)
  end

  it "cannot be created with invalid inputs (one of username, email, or password is missing)" do
    Practitioner.destroy_all
    expect{Practitioner.create!()}.to raise_error ActiveRecord::RecordInvalid  
  end

  it "cannot be created using username that already exists" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    expect{
      Practitioner.create!(
        username: "vincent",
        password: "vincent",
        email: "vince@vince.com",
        department_id: department.id
      )
    }.to raise_error ActiveRecord::RecordInvalid   
  end

  it "cannot be created using email that already exists" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    expect{
      Practitioner.create!(
        username: "vince",
        password: "vincent",
        email: "vincent@vincent.com",
        department_id: department.id
      )
    }.to raise_error ActiveRecord::RecordInvalid   
  end 

  it "can have appointments" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com",
      department_id: department.id
    )

    expect(practitioner.appointments).to be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end
