class EventsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show], except: [:growth_curve]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_attributes)
    @host = Host.find_or_create_by(user_id: current_user.id)
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

  def growth_curve
    @event = Event.find(params[:id])
    data = @event.growth_curve.compact
    render json: data 
  end


  def edit
    set_event
  end

  def update
    @event = set_event
    @event.update(event_attributes)
    if  @event.save
     redirect_to @event
   else
      render 'edit' 
   end  
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
                                 :address,
                                 :latitude,
                                 :longitude,
                                 :city,
                                 :charity_ids => []
                                )
  end 

  def set_event
    @event = Event.find(params[:id])
  end

end
