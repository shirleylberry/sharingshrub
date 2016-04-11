class CausesController < ApplicationController

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


 private

 def cause_attributes
  params.require(:cause).permit(:name)
 end 

end 