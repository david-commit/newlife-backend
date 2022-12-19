class Practitioner < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_one :practitioner_profile, dependent: :destroy

    validates :username, presence: true
    validates :password, presence: true
    validates :email, presence: true
end
