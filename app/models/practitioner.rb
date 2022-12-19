class Practitioner < ApplicationRecord
    has_secure_password

    has_many :appointments

    validates :username, presence: true
    validates :password, presence: true
    validates :email, presence: true
end
