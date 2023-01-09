class User < ApplicationRecord
  has_secure_password

  has_many :appointments, dependent: :destroy
  has_many :practitioners, through: :appointments, dependent: :destroy
  has_many :patient_profiles, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :username,
            presence: {
              message: "Please provide a username"
            },
            uniqueness: {
              message: "A user with that username akready exists"
            }
  validates :password, presence: true
  validates :email,
            presence: {
              message: "Please add an Email"
            },
            uniqueness: {
              message: "A user with that email already exists"
            }
end
