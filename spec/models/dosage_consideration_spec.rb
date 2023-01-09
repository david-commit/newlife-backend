require 'rails_helper'

RSpec.describe DosageConsideration, type: :model do
  it "can be created using valid inputs" do
    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    DosageConsideration.destroy_all
    dosage_consideration = DosageConsideration.create!(
      consideration: "do this",
      product_id: product.id
    )

    expect(dosage_consideration.id.nil?).to eql(false)
  end

  it "can be updated" do
    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    DosageConsideration.destroy_all
    dosage_consideration = DosageConsideration.create!(
      consideration: "do this",
      product_id: product.id
    )

    dosage_consideration.update!(
      consideration: "Okay, I don't know what you should do with this",
    )

    expect(dosage_consideration.consideration).to eql("Okay, I don't know what you should do with this")   
  end

  it "can be destroyed" do
    Product.destroy_all
    product = Product.create!(
      name: "What",
      category: "Whatever",
      price: 2.67
    )

    DosageConsideration.destroy_all
    dosage_consideration = DosageConsideration.create!(
      consideration: "do this",
      product_id: product.id
    )

    dosage_consideration_id = dosage_consideration.id
    dosage_consideration.destroy
    
    expect{DosageConsideration.find(dosage_consideration_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
