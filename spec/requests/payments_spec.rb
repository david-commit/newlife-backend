require 'rails_helper'

RSpec.describe "Payments", type: :request do
  it "can be created" do
    headers  = {"Content-Type": "application/json"}

    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )

    headers = {"Content-Type": "application/json", "Accept": "application/json"}
    
    post "/payments", params: {"business_short_code": "whatever", "order_id": order.id}

    expect(response).to have_http_status(201)
  end

  it "can be viewed (single)" do
    headers  = {"Content-Type": "application/json"}

    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

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
    
    get "/payments/#{payment.id}" 
    
    expect(JSON.parse(response.body)).to be_kind_of(Hash)
  end

  it "can be viewed (all payments)" do
    get "/payments"
    expect(JSON.parse(response.body)).to be_kind_of(Array)
  end

  it "can be destroyed" do
    headers  = {"Content-Type": "application/json"}

    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

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
    
    delete "/payments/#{payment.id}"

    expect(response).to have_http_status(:no_content)
  end
end
