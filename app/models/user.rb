class User < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_many :practitioners, through: :appointments, dependent: :destroy
    has_one :patient_profile, dependent: :destroy
    has_many :orders, dependent: :destroy
    
    validates :username, presence: true
    validates :password, presence: true
    validates :email, presence: true
end
