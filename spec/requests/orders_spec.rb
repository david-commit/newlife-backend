require 'rails_helper'

RSpec.describe "Orders", type: :request do
  it "can be created with valid parameters" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    post '/orders', params: {"user_id": user.id, "delivered": 0}, headers: {"Accept": "application/json", "Authorization": token}

    expect(response).to have_http_status(201)
  end

  it "can be updated if the order has not been fulfilled (delivered) yet" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )
  
    patch "/orders/#{order.id}", params: {"delivered": 1}, headers: {"Accept": "application/json", "Authorization": token}

    expect(JSON.parse(response.body)["delivered"]).to eql(true)     
  end

  it "can be destroyed if the order has not been fulfilled (delivered) yet" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )

    delete "/orders/#{order.id}", headers: {"Accept": "application/json", "Authorization": token}

    expect(response).to have_http_status(204)    
  end

  it "cannot be edited if the order has been fulfilled already" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
    )
  
    patch "/orders/#{order.id}", params: {"delivered": 1}, headers: {"Accept": "application/json", "Authorization": token}

    patch "/orders/#{order.id}", params: {"delivered": 1}, headers: {"Accept": "application/json", "Authorization": token}
        
    expect(response).to have_http_status(400)     
  end

  it "cannot be destroyed if the order has been fulfilled already" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
    )
  
    patch "/orders/#{order.id}", params: {"delivered": 1}, headers: {"Accept": "application/json", "Authorization": token}

    delete "/orders/#{order.id}", headers: {"Accept": "application/json", "Authorization": token}
        
    expect(response).to have_http_status(400)     
  end  
end
