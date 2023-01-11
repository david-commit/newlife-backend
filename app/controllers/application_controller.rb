class ApplicationController < ActionController::API
  before_action :authorized

  def issue_token(user, user_type="user")   
    if(user_type == "user")
      JWT.encode({ user_id: user.id}, ENV["jwt_secret_key"])
    elsif(user_type == "admin")
      JWT.encode({ admin_id: user.id}, ENV["jwt_secret_key"]) 
    elsif(user_type == "practitioner")  
      JWT.encode({ practitioner_id: user.id}, ENV["jwt_secret_key"])  
    end
  end

  def token
    request.headers["Authorization"]
  end

  def decoded_token
    begin
      JWT.decode(token, ENV["jwt_secret_key"])
    rescue => exception
      [{ error: "Invalid Token" }]
    end
  end

  def current_user
    if(!decoded_token.first["admin_id"].nil?)
      return Admin.find_by(id: decoded_token.first["admin_id"])
    elsif(!decoded_token.first["user_id"].nil?)
      return User.find_by(id: decoded_token.first["user_id"])
    else
      return Practitioner.find_by(id: decoded_token.first["practitioner_id"])
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
