require 'rails_helper'

RSpec.describe Product, type: :model do
  it "can be created with valid data" do
    Product.destroy_all

    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    expect(product.id.nil?).to eql(false)
  end

  it "cannot be created with invalid data" do
    expect{Product.create!()}.to raise_error ActiveRecord::RecordInvalid
  end
end
