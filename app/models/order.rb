class Order < ApplicationRecord
  belongs_to :user
  has_one :payment
  has_many :shopping_carts, dependent: :destroy
  has_many :products, through: :shopping_carts

  validates :user, presence: true
end
