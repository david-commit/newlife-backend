require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  it "can be created using valid data" do

    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Payment.destroy_all
    payment = Payment.create!(payment_method: "mpesa")
    expect(payment.id.nil?).to eql(false)

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      payment_id: payment.id,
      delivered: false
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    ShoppingCart.destroy_all
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id
    )

    expect(shopping_cart.id.nil?).to eql(false)
  end

  it "cannot be created with invalid data" do
    expect{ShoppingCart.create!()}.to raise_error ActiveRecord::RecordInvalid
  end

  it "is deleted when an order is deleted" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Payment.destroy_all
    payment = Payment.create!(payment_method: "mpesa")
    expect(payment.id.nil?).to eql(false)

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      payment_id: payment.id,
      delivered: false
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    ShoppingCart.destroy_all
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id
    )
    
    shopping_cart_id = shopping_cart.id
    order.destroy

    expect{ShoppingCart.find(shopping_cart_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
