class CartController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def show
        if(params[:user_id])
            last_order = User.find(params[:user_id]).orders.last

            if(last_order.nil?)
                last_order = Order.create!(user_id: params[:user_id], delivered: false)
            end

            if(params["show_details"] == "true")
                render json: last_order, status: :ok
            else
                render json: ShoppingCart.where("order_id = ?", last_order.id), status: :ok
            end
        else
            render json: {error: "Unauthorized. Please log in first"}
        end
    end

    private
    def user_params
        params.permit(:password_confirmation, :password, :email, :username)
    end

    def record_invalid(invalid)
        render json: {
                errors: invalid.record.errors.full_messages
            },
            status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end
end
