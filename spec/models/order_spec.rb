require 'rails_helper'

RSpec.describe Order, type: :model do
  it "can be created with valid data (must contain user and payment)" do

    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Payment.destroy_all
    payment = Payment.create!(payment_method: "mpesa")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      payment_id: payment.id,
      delivered: false
    )

    expect(order.id.nil?).to eql(false)
  end

  it "cannot be created with invalid data" do
    Order.destroy_all
    expect{Order.create!()}.to raise_error ActiveRecord::RecordInvalid 
  end

  it "is destroyed when a user is destroyed" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Payment.destroy_all
    payment = Payment.create!(payment_method: "mpesa")

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      payment_id: payment.id,
      delivered: false
    )
    
    order_id = order.id
    user.destroy
    expect{Order.find(order_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
