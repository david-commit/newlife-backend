class Department < ApplicationRecord
    has_many :department_practitioners
    has_many :practitioners, through: :department_practitioners

    validates :name, presence: true
end
