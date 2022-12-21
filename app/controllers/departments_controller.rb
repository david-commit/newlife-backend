class DepartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # before_action :authorize

    def index
        render json: Department.all, status: :ok
    end

    def show
        render json: Department.find(params[:id]), status: :ok
    end
    
    private
    def authorize
        User.find(session[:user_id])
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end    
end
