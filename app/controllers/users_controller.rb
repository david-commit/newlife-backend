class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :authorized, only: %i[create show]

  def index
    render json: User.all
  end

  def create
    user = User.create!(user_params)
    token = issue_token(user)
    render json: {user: user, jwt: token}, status: :created
  end

  def show
    user = User.find(params[:id])
    token = issue_token(user, "user")
    render json: {user: user, jwt: token}, status: :ok
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:password_confirmation, :password, :email, :username)
  end

  def record_invalid(invalid)
    render json: {
             errors: invalid.record.errors.full_messages
           },
           status: :unprocessable_entity
  end

  def record_not_found(not_found)
    render json: not_found, status: 404
  end
end
