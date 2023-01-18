class ShoppingCart < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true
  validates :quantity, presence: true, numericality: {greater_than: 0}
  validate :order_product_combination

  # Ensure no more than one same product order combination
  # For instance, if there is a shopping cart with in the 
  # format {product_id: 1, order_id: 1, quantity: 1}, a user
  # should not be allowed to create another shopping cart 
  # with the same combination. ie, same product_id and order_id.
  def order_product_combination
    shopping_carts = ShoppingCart.where("order_id = ?", order_id)
    if(!shopping_carts.find_by(product_id: product_id).nil?)
      errors.add(:invalid_cart_creation, "product with id=#{product_id} already exists in this cart. You can either remove it, or change its quantity in the cart")
    end
  end
end
