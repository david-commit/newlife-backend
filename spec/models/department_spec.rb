require 'rails_helper'

RSpec.describe Department, type: :model do
  it "can be created with valid input" do
    Department.destroy_all

    department = Department.create(name: "Human Resource")
    expect(department.id.nil?).to eql(false)
  end

  it "cannot be created with invalid data" do
    Department.destroy_all

    expect{Department.create!()}.to raise_error ActiveRecord::RecordInvalid   
  end

  it "can have many practitioners" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")
    expect(department.id.nil?).to eql(false)

   expect(department.practitioners).to be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end
