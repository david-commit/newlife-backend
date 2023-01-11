class SessionsController < ApplicationController
    skip_before_action :authorized, only: %i[create]
    rescue_from NoMethodError, with: :couldnt_log_you_in
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        user = User.find_by!(username: params[:username])
        user = user.authenticate(params[:password])
        token = issue_token(user, "user")
        
        user_info = JSON.parse(
            user.to_json only: [:id, :username, :email],
            include: [:orders, :appointments, :patient_profiles]
        )

        render json: {user: user_info, jwt: token }, status: :created
    end

    def destroy
        make_login_status_false
        head :no_content
    end

    private
    def user_params
        params.permit(:username, :password)
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end  
    
    def couldnt_log_you_in
        render json: {error: "Couldn't log you in. Check to confirm if your passowrd is correct"}, status: :unprocessable_entity
    end
end
