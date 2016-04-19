class CausesController < ApplicationController

 before_action :authenticate_admin!, only: [:new, :create]

 def new
  @cause = Cause.new
 end 

 def create
  @cause = Cause.new(cause_attributes)
  @cause.save
 end

 def show
  @cause = Cause.find(params[:id])
 end  

 def index
  @causes = Cause.all
 end

 def pie_chart
  data = Pledge.pledged_amount_by_cause
  render json: data 
 end 

 private

 def cause_attributes
  params.require(:cause).permit(:name)
 end 

end 