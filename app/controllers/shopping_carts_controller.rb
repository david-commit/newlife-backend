class ShoppingCartsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :authorized, only: %i[index]

  # before_action :authorize
  def index
    render json: ShoppingCart.all
  end

  def create
    render json: ShoppingCart.create!(shopping_cart_params), status: :created
  end

  def update
    shopping_cart = ShoppingCart.find(params[:id])
    shopping_cart.update(shopping_cart_params)

    render json: shopping_cart, status: :ok
  end

  def destroy
    shopping_cart = ShoppingCart.find(params[:id])
    shopping_cart.destroy

    head :no_content
  end

  def show
    render json: ShoppingCart.find(params[:id]),
           serializer: ShoppingCartDetailedSerializer,
           status: :ok
  end

  def index
    if (params[:user_id])
      user = User.find(params[:user_id])
      render json: user.orders,
             each_serializer: OrderShoppingCartSerializer,
             status: :ok
    else
      render json: ShoppingCart.all, status: :ok
    end
  end

  private

  def authorize
    User.find(session[:user_id])
  end

  def shopping_cart_params
    params.permit(:order_id, :product_id)
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
