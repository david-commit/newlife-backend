require 'rails_helper'

RSpec.describe Payment, type: :model do
  it "can be created" do
    payment = Payment.create!(payment_method: "mpesa")
    expect(payment.id.nil?).to eql(false)
  end

  it "can be updated" do
     payment = Payment.create!(payment_method: "mpesa")
     payment.update(payment_method: "paypal")
     expect(payment.payment_method).to eql("paypal")
  end

  it "can be deleted" do
    payment = Payment.create!(payment_method: "mpesa")
    payment_id = payment.id
    payment.destroy
    expect{Payment.find(payment_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
