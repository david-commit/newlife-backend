class MessagesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize
    
    def create
        render json: Message.create!(message_params), status: :created
    end

    def index
        if params[:appointment_id]
            render json: Appointment.find(params[:appointment_id]).messages, status: :ok
        else
            render json: Message.all, status: :ok
        end
    end

    def show
        render json: Message.find(params[:id]), status: :ok
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
