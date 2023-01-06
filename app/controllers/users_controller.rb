class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :authorized, only: %i[create index]

  def index
    render json: User.all
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user_id)
      render json: { user: UserSerializer.new(@user) }, status: :created
    else
      render json: {
               error: "failed to create user"
             },
             status: :unprocessable_entity
    end
  end

  def show
    # render json: User.find(session[:user_id]), status: :ok
    render json: User.find(params[:id])
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
