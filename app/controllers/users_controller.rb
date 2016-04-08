class UsersController < ApplicationController
    
    skip_before_action :require_login, only: [:new, :create]
    
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_attributes)
      if @user.save
        redirect_to root_url, :notice => "Signed up!"
      else
        render "new"
      end
    end

    def show
      set_user
    end

    private

    def user_attributes
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
