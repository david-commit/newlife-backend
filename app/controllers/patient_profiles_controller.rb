class PatientProfilesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize

    def create
        render json: PatientProfile.create!(patient_profile_params), status: :created
    end

    def show
        render json: PatientProfile.find(params[:id]), status: :ok
    end

    def index
        render json: PatientProfile.all, status: :ok
    end

    def update
        patient_profile = PatientProfile.find(params[:id])
        patient_profile.update(patient_profile_params)
        render json: patient_profile, status: :ok
    end

    def destroy
        PatientProfile.find(params[:id]).destroy
        head :no_content
    end
    
    private
    def patient_profile_params
        params.permit(:user_id, :first_name, :last_name, :bio, :dob, :location, :blood_group, :height, :weight, :phone_number, :bmi, :email)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end     
end
