class Product < ApplicationRecord
    has_many :shopping_carts
    has_many :orders, through: :shopping_carts
    
    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true
end
