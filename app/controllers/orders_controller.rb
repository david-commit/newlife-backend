class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize

    def create
        render json: Order.create!(order_params), status: :created
    end

    def update
        order = Order.find(params[:id])

        if(order.delivered)
            render json: {error: "Cannot edit an order that has already been fulfilled"}, status: 400
        else
            order.update(delivered: params[:delivered])
            render json: order, status: :ok
        end
    end

    def destroy
        order = Order.find(params[:id])
        if (order.delivered)
            render json: {error: "cannot destroy order that has already been fulfilled"}, status: 400
        else
            order.destroy
            head :no_content
        end
    end

    def show
        render json: Order.find(params[:id]), status: :ok
    end

    def index
        if(params[:user_id])
            render json: User.find(params[:user_id]).orders, status: :ok
        else
            render json: {error: "cannot see orders not belonging to you"}, status: :unprocessable_entity
        end
    end
    
    private
    def authorize
        User.find(session[:user_id])
    end

    def order_params
        params.permit(:user_id, :delivered)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end     
end
