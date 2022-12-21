class Order < ApplicationRecord
  belongs_to :user
  has_one :payment, dependent: :destroy
  has_many :shopping_carts, dependent: :destroy
  has_many :products, through: :shopping_carts, dependent: :destroy

  validates :user_id, presence: true
end
