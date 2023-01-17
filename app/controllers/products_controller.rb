class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  skip_before_action :authorized, only: %i[index show search average_rating]

  def index
    render json: Product.all, status: :ok
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: :ok
  end

  def search
    product = Product.search_by_name(params[:query])
    render json: product
  end

  def create
    if (params[:admin_id])
      render json: Product.create!(product_params), status: :created
    else
      render json: { error: "Not authorized" }, status: 401
    end
  end

  def average_rating
    product = Product.find(params[:id])
    average_rating = product.average_rating
    render json: { average_rating: average_rating }
  end

  def update
    if (params[:admin_id])
      product = Product.find(params[:id])
      product.update(product_params)
      render json: product, status: :created
    else
      render json: { error: "Not authorized" }, status: :ok
    end
  end

  def destroy
    if (params[:admin_id])
      product = Product.find(params[:id])
      product.destroy
      head :no_content
    else
      render json: { error: "Not authorized" }, status: 401
    end
  end

  private

  def render_record_not_found
    render json: { error: "Product not found" }, status: :not_found
  end

  def product_params
    params.permit(
      :name,
      :category,
      :price,
      :description,
      :image,
      :dosage,
      :stock
    )
  end
end
