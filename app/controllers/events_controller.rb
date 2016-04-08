class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_attributes)
        binding.pry 

   if  @event.save
     redirect_to @event
    
   else
      render 'new' 
   end   
  end


  def show

  end 





  private

  def event_attributes
  
   params.require(:event).permit(:title, :charities, :goal, 
    :event_start_date_part, :event_start_time_part,
    :event_end_date_part, :event_end_time_part)

  end 
end
