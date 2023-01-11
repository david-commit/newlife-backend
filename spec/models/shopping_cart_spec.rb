require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  it "can be created using valid data" do

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

    Payment.destroy_all
    payment = Payment.create!(business_short_code: "mpesa", order_id: order.id)
    expect(payment.id.nil?).to eql(false)

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
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )    

    Payment.destroy_all
    payment = Payment.create!(business_short_code: "mpesa", order_id: order.id)
    expect(payment.id.nil?).to eql(false)

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
