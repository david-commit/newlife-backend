class PractitionerSessionsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        practitioner = Practitioner.find_by!(username: params[:username])
        render json: practitioner.authenticate(params[:password]), status: :created
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
