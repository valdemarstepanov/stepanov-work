class HomeController < ApplicationController
  
    def index
      @users = User.all
    end

    def create
        @user = User.create(user_params)
    end

    private

    def user_params
        params.require(:user).permit(:id, :email, :role, :user_id )
    end
end
