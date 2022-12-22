class PaymentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize
    
    def create
        render json: Payment.create!(payment_params), status: :created
    end

    def update
        payment = Payment.find(params[:id])
        payment.update(payment_params)
        
        render json: payment, status: :ok
    end

    def index
        if(params[:user_id])
            render json: User.find(params[:user_id]).payments, status: :ok
        else
            render json: Payment.all, status: :ok
        end
    end

    def show
        render json: Payment.find(params[:id]), status: :ok
    end

    def destroy
        Payment.find(params[:id]).destroy
        head :no_content
    end
    
    private
    def authorize
        User.find(session[:user_id])
    end

    def payment_params
        params.permit(:payment_method, :order_id)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end     
end
