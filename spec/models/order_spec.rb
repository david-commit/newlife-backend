require 'rails_helper'

RSpec.describe Order, type: :model do
  it "can be created with valid data (must contain user and payment)" do

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
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    )
    
    order_id = order.id
    user.destroy
    expect{Order.find(order_id)}.to raise_error ActiveRecord::RecordNotFound
  end

  it "can have many shopping carts" do
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

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    ShoppingCart.destroy_all
    shopping_cart1 = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id,
      quantity: 1
    )

    shopping_cart2 = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id,
      quantity: 1
    )
    
    expect(order.shopping_carts).to be_kind_of(ActiveRecord::Associations::CollectionProxy)    
  end

  it "can have many products" do
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

    Product.destroy_all
    product1 = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    product2 = Product.create!(
      name: "Another Product",
      category: "Whatever",
      price: 2.67
    )    

    ShoppingCart.destroy_all
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product1.id,
      quantity: 1
    )

    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product2.id,
      quantity: 1
    )
    
    expect(order.products).to be_kind_of(ActiveRecord::Associations::CollectionProxy)        
  end
end
