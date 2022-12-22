require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    it "allows one to login" do
      headers = {"ContentType": "application/json"}
      post '/signup', params: {"username": "what", "password": "what", "email": "what@what.com"}
      post '/login', params: {"username": "what", "password": "what", "email": "what@what.com"}

      expect(response).to have_http_status(201)
    end

    it "allows one to logout" do

    end
end
