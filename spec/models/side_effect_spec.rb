require 'rails_helper'

RSpec.describe SideEffect, type: :model do
  it "can be created using valid inputs" do
    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    SideEffect.destroy_all
    side_effect = SideEffect.create!(
      side_effect: "bad bad bad",
      product_id: product.id
    )

    expect(side_effect.id.nil?).to eql(false)
  end

  it "can be updated" do
    User.destroy_all
    user = User.create!(
      username: "vincent",
      password: "vincent",
      email: "vincent@vincent.com"
    )

    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    SideEffect.destroy_all
    side_effect = SideEffect.create!(
      side_effect: "bad bad bad",
      product_id: product.id
    )

    side_effect.update!(
      side_effect: "Not exactly bad, but still bad",
    )

    expect(side_effect.side_effect).to eql("Not exactly bad, but still bad")   
  end
end
