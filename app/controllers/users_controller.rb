class UsersController < ApplicationController

  def show
    if User.find(params[:id]) == current_user
      @user = current_user
    else 
      redirect_to root_path
    end 
  end 

  def cause_chart
    @user = User.find(params[:id])
    data = @user.donor.pledged_amount_by_cause
    render json: data 
  end 

end
