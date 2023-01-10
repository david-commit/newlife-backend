require 'rails_helper'

RSpec.describe "Orders", type: :request do
  it "can be created with valid parameters" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    headers = {"Content-Type": "application/json"}
    post '/orders', params: {"user_id": user.id, "delivered": 0}

    expect(response).to have_http_status(201)
  end

  it "can be updated if the order has not been fulfilled (delivered) yet" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )
  
    headers = {"Content-Type": "application/json"}
    patch "/orders/#{order.id}", params: {"delivered": 1}

    expect(JSON.parse(response.body)["delivered"]).to eql(true)     
  end

  it "can be destroyed if the order has not been fulfilled (delivered) yet" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )

    headers = {"Content-Type": "application/json"}
    delete "/orders/#{order.id}"

    expect(response).to have_http_status(204)    
  end

  it "cannot be edited if the order has been fulfilled already" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
    )
  
    headers = {"Content-Type": "application/json"}
    patch "/orders/#{order.id}", params: {"delivered": 1}

    headers = {"Content-Type": "application/json"}
    patch "/orders/#{order.id}", params: {"delivered": 1}
        
    expect(response).to have_http_status(400)     
  end

  it "cannot be destroyed if the order has been fulfilled already" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
    )
  
    headers = {"Content-Type": "application/json"}
    patch "/orders/#{order.id}", params: {"delivered": 1}

    headers = {"Content-Type": "application/json"}
    delete "/orders/#{order.id}"
        
    expect(response).to have_http_status(400)     
  end  
end
