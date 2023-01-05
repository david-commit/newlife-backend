class AuthenticationController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username])
  end

  private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end
end
