class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    #store secret in env variable
    JWT.encode(payload, "my_s3cr3t")
  end

  def auth_header
  end

  def auth_header
  end

  def decoded_token
  end
end
