class Review < ApplicationRecord
  belongs_to :product

  validates :rating,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than: 6
            }
  validates :description_header, presence: true
  validates :description_content, presence: true
  validates :user_id, presence: true

  def self.average_rating
    average(:rating)
  end
end
