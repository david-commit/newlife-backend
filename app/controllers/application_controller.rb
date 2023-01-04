class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    #store secret in env variable
    JWT.encode(payload, "my_s3cr3t")
  end

  # authorization bearer token
  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_token
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, "my_s3cr3t", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      else
      end
    end
  end

  def current_user
  end
end
