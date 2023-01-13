class PractitionerProfilesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize

    def create
        render json: PractitionerProfile.create!(practitioner_profile_params), status: :created
    end

    def show
        render json: PractitionerProfile.find(params[:id]), status: :ok
    end

    def index
        render json: PractitionerProfile.all, status: :ok
    end

    def update
        practitioner_profile = PractitionerProfile.find(params[:id])
        practitioner_profile.update(practitioner_profile_params)
        render json: practitioner_profile, status: :ok
    end

    def destroy
        PractitionerProfile.find(params[:id]).destroy
        head :no_content
    end
    
    private
    def practitioner_profile_params
        params.permit(:practitioner_id, :first_name, :last_name, :bio, :dob, :location, :blood_group, :height, :weight, :phone_number, :bmi, :job_title, :email)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end   
end
