class ProductsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def index
        render json: Product.all, status: :ok
    end

    def show
        product = Product.find(params[:id])
        render json: product, status: :ok
    end

    def create
        if(params[:admin_id])
            render json: Product.create!(product_params), status: :created
        else
            render json: {error: "Not authorized"}, status: 401
        end
    end

    def update
        if(params[:admin_id])
            product = Product.find(params[:product_id])
            product.update(product_params)
            render json: product, status: :created
        else
            render json: {error: "Not authorized"}, status: :ok
        end
    end

    def destroy
        if(params[:admin_id])
            product = Product.find(params[:product_id])
            product.destroy
            head :no_content
        else
            render json: {error: "Not authorized"}, status: 401
        end
    end

    private

    def render_record_not_found
        render json: { error: "Product not found" }, status: :not_found
    end

    def product_params
        params.permit(:name, :category, :price, :description, :image, :dosage, :stock)
    end
end
