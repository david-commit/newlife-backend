class User < ApplicationRecord
    has_secure_password

    has_many :appointments
    has_one :patient_profile
    
    validates :username, presence: true
    validates :password, presence: true
    validates :email, presence: true
end
