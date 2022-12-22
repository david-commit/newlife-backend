class Practitioner < ApplicationRecord
    has_secure_password

    has_many :appointments, dependent: :destroy
    has_many :users, through: :appointments, dependent: :destroy
    has_many :practitioner_profiles, dependent: :destroy
    belongs_to :department

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :email, presence: true, uniqueness: true
end
