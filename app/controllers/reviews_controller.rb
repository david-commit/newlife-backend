class ReviewsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize

    def create
        byebug
        render json: Review.create!(review_params), status: :created
    end

    def index
        render json: Review.all, status: :ok
    end

    def show
        render json: Review.find(params[:id]), status: :ok
    end

    def update
        review = Review.find(params[:id])
        review.update(review_params)
        render json: review, status: :ok
    end

    def average

        review 
    end

    def destroy
        review = Review.find(params[:id])
        review.destroy
        head :no_content
    end

    private
    def review_params
        params.permit(:rating, :description_header, :description_content, :product_id, :user_id)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end

    def authorize
        User.find(session[:user_id])
    end
end
