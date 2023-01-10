class SideEffectsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize
    def create
        render json: SideEffect.create!(side_effect_params), status: :created
    end

    def show
        render json: SideEffect.find(params[:id]), status: :ok
    end

    def index
        render json: SideEffect.all, status: :ok
    end

    def update
        side_effect = SideEffect.find(params[:id])
        side_effect.update(side_effect_params)
        render json: :side_effect, status: :ok
    end

    def destroy
        side_effect = SideEffect.find(params[:id])
        side_effect.destroy
        head :no_content
    end

    private
    def side_effect_params
        params.permit(:side_effect, :product_id)
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
