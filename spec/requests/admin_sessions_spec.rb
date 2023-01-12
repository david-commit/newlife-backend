require 'rails_helper'

RSpec.describe "AdminSessions", type: :request do
  it "allows loggin in" do
    Admin.find_by(username: "what")&.destroy_all
    Admin.find_by(email: "email")&.destroy_all

    what = Admin.create!(email: "what", username: "what", password: "Passw0rd3")
    
    post "/admin/login", params: {username: "what", password: "Passw0rd3"}

    expect(response).to have_http_status(201)
  end
end
