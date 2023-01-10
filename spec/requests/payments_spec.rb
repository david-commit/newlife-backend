require 'rails_helper'

RSpec.describe "Payments", type: :request do
  it "can be created" do
    headers  = {"Content-Type": "application/json"}

    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )
    
    post "/payments", params: {"business_short_code": "whatever", "order_id": order.id}, headers: {
      "Accept": "application/json", "Authorization": token
    }

    expect(response).to have_http_status(201)
  end

  it "can be viewed (single)" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )

    Payment.destroy_all
    payment = Payment.create!(
      business_short_code: "whatever",
      order_id: order.id
    )
    
    get "/payments/#{payment.id}", headers: {
      "Accept": "application/json", "Authorization": token
    }
    
    expect(JSON.parse(response.body)).to be_kind_of(Hash)
  end

  it "can be viewed (all payments)" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    get "/payments", headers: {
      "Accept": "application/json", "Authorization": token
    }
    expect(JSON.parse(response.body)).to be_kind_of(Array)
  end

  it "can be destroyed" do
    headers  = {"Content-Type": "application/json"}

    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )

    Payment.destroy_all
    payment = Payment.create!(
      business_short_code: "whatever",
      order_id: order.id
    )
    
    delete "/payments/#{payment.id}", headers: {
      "Accept": "application/json", "Authorization": token
    }

    expect(response).to have_http_status(:no_content)
  end
end
