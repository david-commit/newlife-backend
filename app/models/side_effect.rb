class SideEffect < ApplicationRecord
  belongs_to :product

  validates :product_id, presence: true
  validates :side_effect, presence: true
end
