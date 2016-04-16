class UsersController < ApplicationController

  def show
    if User.find(params[:id]) == current_user
      @user = current_user
    else 
      redirect_to root_path
    end 
  end 

end
