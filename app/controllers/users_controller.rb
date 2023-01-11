class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :authorized, only: %i[create index send_email]

  def index
    render json: User.all
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = issue_token(user)
      # MyMailer.send_email(user.email, "Hello", "Pokea").deliver_now
      render json: {
               user: UserSerializer.new(user),
               jwt: token
             },
             status: :created
    else
      render json: {
               error: "failed to create user"
             },
             status: :unprocessable_entity
    end
  end

  def send_email
    user = User.find(params[:id])
    MyMailer.send_email(
      user.email,
      "Hello",
      "This is the email body"
    ).deliver_now
    render json: { message: "Email sent!" }, status: :ok
  end

  def show
    user = User.find(params[:id])
    if user
      render json: user
    else
      render json: { error: "User could not be found" }
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  def send_email
    @user = User
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
