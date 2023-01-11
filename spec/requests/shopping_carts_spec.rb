require 'rails_helper'

RSpec.describe "ShoppingCarts", type: :request do
  it "can be created" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

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

    post '/shopping_carts', params: {"order_id": order.id, "product_id": product.id}, headers: {"Accept": "application/json", "Authorization": token}

    expect(response).to have_http_status(201)
  end

  it "can be updated" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

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
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id
    )     
    
    product2 = Product.create!(
      name: "Another One",
      category: "Another One",
      price: 2.67
    ) 
    
    patch "/shopping_carts/#{shopping_cart.id}", params: {"order_id": order.id, "product_id": product2.id}, headers: {"Accept": "application/json", "Authorization": token} 
    
    expect(JSON.parse(response.body)["product_id"]).to eql(product2.id)
  end

  it "can be destroyed" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

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
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id
    )

    delete "/shopping_carts/#{shopping_cart.id}", headers: {"Accept": "application/json", "Authorization": token}

    expect(response).to have_http_status(204)
  end

  it "can be viewed singly, providing details of order and products" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}

    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

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
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id
    )

    get "/shopping_carts/#{shopping_cart.id}", headers: {"Accept": "application/json", "Authorization": token}
    
    expect(JSON.parse(response.body).keys).to eql(["id", "order_id", "product_id", "order", "product"])
  end

  it "can be viewed in the context of a user, showing products in each order made by that user" do
    User.destroy_all
    post '/signup', params: {"username": "what", "password": "Passw0rd3", "email": "what@what.com"}
    token = JSON.parse(response.body)["jwt"]
    user = User.find_by(email: "what@what.com")

    post '/signup', params: {"username": "enock", "password": "Passw0rd3", "email": "enock@enock.com"}
    token2 = JSON.parse(response.body)["jwt"]
    user2 = User.find_by(email: "enock@enock.com")   

    Order.destroy_all
    order = Order.create!(
      user_id: user.id,
      delivered: false
    ) 
    
    order2 = Order.create!(
      user_id: user.id,
      delivered: false
    )  
    
    order3 = Order.create!(
      user_id: user2.id,
      delivered: false
    )    

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )
    
    product2 = Product.create!(
      name: "Product 2",
      category: "Product 2",
      price: 2.67
    ) 
    
    product2 = Product.create!(
      name: "Product 3",
      category: "Product 3",
      price: 2.67
    ) 
    
    ShoppingCart.destroy_all
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product.id
    ) 
    
    shopping_cart = ShoppingCart.create!(
      order_id: order.id,
      product_id: product2.id
    )
    
    shopping_cart = ShoppingCart.create!(
      order_id: order2.id,
      product_id: product2.id
    ) 
    
    shopping_cart = ShoppingCart.create!(
      order_id: order3.id,
      product_id: product.id
    ) 
    
    shopping_cart = ShoppingCart.create!(
      order_id: order3.id,
      product_id: product2.id
    )  
    
    headers = {"Content-Type": "application/json", "Accept": "application/json"}
    get "/users/#{user.id}/shopping_carts", headers: {"Accept": "application/json", "Authorization": token}

    expect(JSON.parse(response.body).length).to eql(2)
  end
end
