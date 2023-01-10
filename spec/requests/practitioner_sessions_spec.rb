require 'rails_helper'

RSpec.describe "PractitionerSessions", type: :request do
    it "allows one to login" do
      Department.destroy_all
      department = Department.create!(name: "Human Resource")

      Practitioner.destroy_all
      headers = {"ContentType": "application/json"}
      post '/practitioner/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com", "department_id": department.id}

      post '/practitioner/login', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

      expect(response).to have_http_status(201)
    end

    it "allows one to logout" do

    end
end
