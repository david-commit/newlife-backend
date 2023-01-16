class CartController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def show
        if(params["show_details"] == "true")
            render json: Order.last, status: :ok
        else
            last_order_id = Order.last&.id
            render json: ShoppingCart.where("order_id = ?", last_order_id), status: :ok
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
