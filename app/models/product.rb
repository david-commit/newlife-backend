class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name,
                  against: %i[name category],
                  using: {
                    tsearch: {
                      prefix: true
                    }
                  }

  def average_rating
    reviews.average(:rating)
  end
  
  has_many :shopping_carts, dependent: :destroy
  has_many :orders, through: :shopping_carts, dependent: :destroy
  has_many :dosage_considerations, dependent: :destroy
  has_many :side_effects, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true
end
