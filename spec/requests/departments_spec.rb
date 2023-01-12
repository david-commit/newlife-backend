require 'rails_helper'

RSpec.describe "Departments", type: :request do
  it "can be viewed wholly" do
    Department.destroy_all
    Department.create(name: "Department 1")
    Department.create(name: "Department 2")

    headers = {"Accept": "application/json"}    
    get "/departments"

    expect(JSON.parse(response.body)).to be_kind_of(Array)
  end

  it "can be viewed singly" do
    Department.destroy_all
    department = Department.create(name: "Department 1")

    headers = {"Accept": "application/json"}    
    get "/departments/#{department.id}"

    expect(JSON.parse(response.body)).to be_kind_of(Hash)    
  end

  it "returns practitioners associated with it too" do
    Department.destroy_all
    department = Department.create(name: "Human Resource")

    Practitioner.destroy_all
    practitioner = Practitioner.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com",
      department_id: department.id
    )
    
    practitioner2 = Practitioner.create!(
      username: "enock",
      password: "enock",
      email: "enock@enock.com",
      department_id: department.id
    )

    headers = {"Accept": "application/json"}    
    get "/departments/#{department.id}"

    expect(JSON.parse(response.body)["practitioners"]).to be_kind_of(Array)
  end
end
