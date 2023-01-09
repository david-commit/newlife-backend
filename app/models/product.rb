class Product < ApplicationRecord
    has_many :shopping_carts
    has_many :orders, through: :shopping_carts
    has_many :dosage_considerations
    has_many :side_effects
    has_many :reviews
    
    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true
end
