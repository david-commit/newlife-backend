class Practitioner < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_one :practitioner_profile, dependent: :destroy
    has_many :department_practitioners
    has_many :departments, through: :department_practitioners

    validates :username, presence: true
    validates :password, presence: true
    validates :email, presence: true
end
