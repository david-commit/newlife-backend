class AppointmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize

    def show
        render json: Appointment.find(params[:id]), status: :ok
    end

    def index
        if(params[:user_id])
            render json: User.find(params[:user_id]).appointments, status: :ok
        else
            render json: Appointment.all, status: :ok
        end
    end

    private
    def authorize
        User.find(session[:user_id])
    end

    def message_params
        params.permit(:content, :sender_id, :receiver_id, :appointment_id, :sender_class, :receiver_class)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end      
end
