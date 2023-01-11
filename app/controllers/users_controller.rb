class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :authorized, only: %i[create index]

  def index
    render json: User.all
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = issue_token(user)
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

  private

  def send_email
    require "sendgrid-ruby"
    include SendGrid

    from = Email.new(email: "test@gmail.com")
    to = Email.new(email: "test@gmail.com")

    subject = "Welcome to Newlife Hospital"
    content =
      Content.new(
        type: "text/plain",
        value: "We are pleased to informyou that the force has chosen you"
      )

    mail = Mail.new(from, subject, to, content)
    sg =
      Sendgrid::API.new(
        api_key:
          "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"
      )
  end

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
