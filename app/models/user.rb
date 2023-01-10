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
              message: "A user with that username already exists"
            }
  validates :password,
            presence: true,
            length: {
              minimum: 8,
              maximum: 16
            },
            confirmation: true,
            format: {
              with: /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}\z/,
              message:
                "must include at least one lowercase letter, one uppercase letter, one digit and have minimum 8 characters"
            }
  validates :email,
            presence: {
              message: "Please add an Email"
            },
            uniqueness: {
              message: "A user with that email already exists"
            }
end
