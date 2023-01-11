class PractitionersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def create
        practitioner = Practitioner.create!(practitioner_params)
        token = issue_token(practitioner, "practitioner")
        render json: {practitioner: practitioner, jwt: token }, status: :created
    end

    def show
        render json: Practitioner.find(params[:id])
    end

    private
    def practitioner_params
        params.permit(:username, :password, :email, :department_id)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end    
end
