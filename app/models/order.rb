class Order < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  has_many :shopping_carts

  validates :user, presence: true
  validates :payment, presence: true
end
