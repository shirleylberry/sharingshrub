class EventsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_attributes)
    @host = Host.find_or_create_by(user: current_user)
    @event.host = @host
   if  @event.save
     redirect_to @event
   else
      render 'new' 
   end   
  end

  def show
    set_event
  end 

  def edit
    set_event
  end

  private

  def event_attributes
   params.require(:event).permit(:title, 
                                 :goal, 
                                 :event_start_date_part, 
                                 :event_start_time_part,
                                 :event_end_date_part, 
                                 :event_end_time_part,
                                 :funded_deadline,
                                 :charity_ids => []
                                )
  end 

  def set_event
    @event = Event.find(params[:id])
  end

end
