class Practitioner < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_many :users, through: :appointments, dependent: :destroy
    has_one :practitioner_profile, dependent: :destroy
    has_many :department_practitioners, dependent: :destroy
    has_many :departments, through: :department_practitioners, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :email, presence: true, uniqueness: true
end
