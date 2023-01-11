require 'rails_helper'

RSpec.describe Review, type: :model do
  it "can be created using valid inputs" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    Review.destroy_all
    review = Review.create!(
      rating: 4,
      description_header: "This is Awesome",
      description_content: "I bought this product and it's one of the most awesome decisions I made in my life",
      product_id: product.id,
      user_id: user.id
    )

    expect(review.id.nil?).to eql(false)
  end

  it "can be updated" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    Review.destroy_all
    review = Review.create!(
      rating: 4,
      description_header: "This is Awesome",
      description_content: "I bought this product and it's one of the most awesome decisions I made in my life",
      product_id: product.id,
      user_id: user.id
    )

    review.update!(
      rating: 1,
      description_header: "Damn",
      description_content: "This product is aweful"
    )

    expect(review.rating).to eql(1)   
  end

it "throws error when created using rating greater than 5" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    Review.destroy_all
    expect{Review.create!(
      rating: 6,
      description_header: "This is Awesome",
      description_content: "I bought this product and it's one of the most awesome decisions I made in my life",
      product_id: product.id,
      user_id: user.id
    )}.to raise_error ActiveRecord::RecordInvalid
  end

it "throws error when created using rating less than 1" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    Review.destroy_all
    expect{Review.create!(
      rating: 0,
      description_header: "This is Awesome",
      description_content: "I bought this product and it's one of the most awesome decisions I made in my life",
      product_id: product.id,
      user_id: user.id
    )}.to raise_error ActiveRecord::RecordInvalid
  end

  it "can be destroyed" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "Passw0rd3",
      email: "vincent@vincent.com"
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    Review.destroy_all
    review = Review.create!(
      rating: 4,
      description_header: "This is Awesome",
      description_content: "I bought this product and it's one of the most awesome decisions I made in my life",
      product_id: product.id,
      user_id: user.id
    )

    review_id = review.id
    review.destroy

    expect{Review.find(review_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
