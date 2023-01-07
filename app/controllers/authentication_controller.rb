class AuthenticationController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by_email(user_login_params[:email])

    if user && user.authenticate(user_login_params[:password])
      token = issue_token(user)
      render json: {
               user: UserSerializer.new(user),
               jwt: token
             },
             status: :accepted
    else
      render json: {
               message: "Invalid username or password"
             },
             status: :unauthorized
    end
  end

  def show
    if logged_in?
      render json: current_user
    else
      render json: { error: "Please log in" }
    end
  end

  private

  def user_login_params
    params.permit(:email, :password)
  end
end
