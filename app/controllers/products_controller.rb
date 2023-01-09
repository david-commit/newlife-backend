class ProductsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def index
        render json: Product.all, status: :ok
    end

    def show
        product = Product.find(params[:id])
        render json: product, status: :ok
    end

    private

    def render_record_not_found
        render json: { error: "Product not found" }, status: :not_found
    end
end
