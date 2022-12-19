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

  it "is deleted when the department it belongs to is deleted" do
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
    
    department_practitioner_id = department_practitioner.id
    department.destroy

    expect{DepartmentPractitioner.find(department_practitioner_id)}.to raise_error ActiveRecord::RecordNotFound
  end

  it "is deleted when the practitioner it belongs to is deleted" do
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
    
    department_practitioner_id = department_practitioner.id
    practitioner.destroy

    expect{DepartmentPractitioner.find(department_practitioner_id)}.to raise_error ActiveRecord::RecordNotFound    
  end
end
