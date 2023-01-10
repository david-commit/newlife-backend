require 'rails_helper'

RSpec.describe "Admins", type: :request do
  it "allows one to signup" do
    Admin.find_by(username: "what")&.destroy_all
    Admin.find_by(email: "email")&.destroy_all

    headers = {"ContentType": "application/json"}
    post '/admin/signup', params: {"username": "what", "password": "what", "email": "what@what.com"}

    expect(response).to have_http_status(201)
  end

  it "allows loggin in" do
    Admin.find_by(username: "what")&.destroy_all
    Admin.find_by(email: "email")&.destroy_all

    what = Admin.create!(email: "what", username: "what", password: "Passw0rd3")

    headers = {"ContentType": "application/json"}
    
    get "/admin/login", params: {id: what.id}

    expect(response).to have_http_status(200)
  end

  it "can be destroyed" do
   Admin.find_by(username: "what")&.destroy_all
    Admin.find_by(email: "email")&.destroy_all

    what = Admin.create!(email: "what", username: "what", password: "Passw0rd3")

    headers = {"ContentType": "application/json"}
    
    delete "/admin/delete_account", params: {id: what.id}

    expect(response).to have_http_status(:no_content)    
  end
end
