class AppointmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        render json: Appointment.create!(appointment_params), status: :created
    end

    def update
        appointment = Appointment.find(params[:id])
        appointment.update(practitioner_update_params)

        render json: appointment, status: :ok
    end

    def destroy
        appointment = Appointment.find(params[:id])
        appointment.destroy
        head :no_content
    end

    def show
        render json: Appointment.find(params[:id]), serializer: AppointmentDetailedSerializer, status: :ok
    end

    def index
        if(params[:user_id])
            render json: User.find(params[:user_id]).appointments, each_serializer: AppointmentDetailedSerializer, status: :ok
        elsif(params[:practitioner_id])
            render json: Practitioner.find(params[:practitioner_id]).appointments, each_serializer: AppointmentDetailedSerializer, status: :ok        
        else
            render json: Appointment.all, status: :ok
        end
    end

    private
    def practitioner_update_params
        params.permit(:date, :approved)
    end

    def appointment_params
        params.permit(:user_id, :practitioner_id, :date, :appointment_type, :appointment_info, :time)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end      
end
