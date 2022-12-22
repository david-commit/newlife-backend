class ProductsController < ApplicationController
    def index
        render json: Product.all, status: :ok
    end
end
