class AuthenticationController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:email])

    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: {
               user: UserSerializer.new(@user),
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
    user = User.find(params[:id])
    if user
      render json: user
    else
      render json: { error: "User could not be found" }
    end
  end

  private

  def user_login_params
    params.permit(:email, :password)
  end
end
