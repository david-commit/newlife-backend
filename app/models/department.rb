class Department < ApplicationRecord
    has_many :practitioners, dependent: :destroy

    validates :name, presence: true
end
