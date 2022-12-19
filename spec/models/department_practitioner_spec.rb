require 'rails_helper'

RSpec.describe DepartmentPractitioner, type: :model do
  it "can be created with valid data" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    DepartmentPractitioner.destroy_all
    department_practitioner = DepartmentPractitioner.create(
      department_id: department.id,
      practitioner_id: practitioner.id
    )
  end

  it "cannot be created with invalid data" do
    expect{DepartmentPractitioner.create!()}.to raise_error ActiveRecord::RecordInvalid
  end
end
