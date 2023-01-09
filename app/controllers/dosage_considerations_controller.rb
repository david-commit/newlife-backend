class DosageConsiderationsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize
    def create
        render json: DosageConsideration.create!(dosage_consideration_params), status: :ok
    end

    def index
        render json: DosageConsideration.all, status: :ok
    end

    def show
        render json: DosageConsideration.find(params[:id]), status: :ok
    end

    def update
        dosage_consideration = DosageConsideration.find(params[:id])
        dosage_consideration.update(dosage_consideration_params)
        render json: dosage_consideration, status: :ok
    end

    def destroy
        dosage_consideration = DosageConsideration.find(params[:id])
        dosage_consideration.destroy
        head :no_content
    end

    private
    def authorize
        User.find(session[:user_id])
    end

    def dosage_consideration_params
        params.permit(:consideration, :product_id)
    end

    def appointment_params
        params.permit(:user_id, :practitioner_id, :date, :appointment_type)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end       
end
