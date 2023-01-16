require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "allows one to signup" do
    User.find_by(username: "what")&.destroy_all
    User.find_by(email: "email")&.destroy_all

    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    expect(response).to have_http_status(201)
  end
end
