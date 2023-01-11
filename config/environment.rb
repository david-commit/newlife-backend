# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
config.action_mailer.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  domain: "https://newlife-production.up.railway.app",
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  user_name: "apikey",
  password: ENV["SENDGRID_API_KEY"],
  enable_starttls_auto: true
}
