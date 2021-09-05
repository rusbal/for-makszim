module V1
  class UsersController < ApplicationController
    before_action :authenticate_user

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def create
      user = User.new(user_params)

      if user.save
        success
      else
        failure
      end
    end

    def update
      user = User.find(params[:id])

      if user.update(user_params)
        success
      else
        failure
      end
    rescue ActiveRecord::RecordNotFound
      failure
    end

    def destroy
      user = User.find(params[:id])

      if user.delete
        success
      else
        failure
      end
    rescue ActiveRecord::RecordNotFound
      failure
    end

    private

    def user_params
      params.permit(:first_name, :last_name)
    end
  end
end
