class Department < ApplicationRecord
    has_many :department_practitioners, dependent: :destroy
    has_many :practitioners, through: :department_practitioners, dependent: :destroy

    validates :name, presence: true
end
