class ApplicationController < ActionController::API
  before_action :authorized

  def jwt_key
    Rails.application.credentials.jwt_key
  end

  def encode_token(user)
    JWT.encode({ user_id: user.id }, jwt_key, "HS256")
  end

  def token
    request.headers["Authorization"]
  end

  def decoded_token
    begin
      JWT.decode(token, jwt_key, true, { algorithm: "HS256" })
    rescue => exception
      [{ error: "Invalid Token" }]
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    unless logged_in?
      render json: { message: "Please log in" }, status: :unauthorized
    end
  end
end
