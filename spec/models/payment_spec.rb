require 'rails_helper'

RSpec.describe Payment, type: :model do
  it "can be created with valid data" do
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
      payment_method: "mpesa",
      order_id: order.id
    )
    
    expect(payment.id.nil?).to eql(false)
  end

  it "cannot be created with invalid data" do
    expect{Order.create!()}.to raise_error ActiveRecord::RecordInvalid
  end
end
