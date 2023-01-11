class PractitionerSessionsController < ApplicationController
    skip_before_action :authorized, only: %i[create]
    
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        practitioner = Practitioner.find_by!(username: params[:username])
        practitioner = practitioner.authenticate(params[:password])
        token = issue_token(practitioner, "practitioner")
        
        practitioner_info = JSON.parse(
            practitioner.to_json only: [:id, :username, :email],
            include: [:appointments, :practitioner_profiles]
        )

        render json: {practitioner: practitioner_info, jwt: token }, status: :created
    end

    def destroy
        #session.delete :user_id
        #head 202
    end

    private
    def user_params
        params.permit(:username, :password)
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end      
end
