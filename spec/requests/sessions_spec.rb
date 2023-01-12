require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    it "allows one to login" do
      headers = {"ContentType": "application/json"}
      post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

      token = JSON.parse(response.body)["jwt"]
      
      post '/login', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

      expect(response).to have_http_status(201)
    end
end
