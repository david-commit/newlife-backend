class User < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_many :practitioners, through: :appointments, dependent: :destroy
    has_many :patient_profiles, dependent: :destroy
    has_many :orders, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :email, presence: true, uniqueness: true
end
