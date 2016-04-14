class PledgesController < ApplicationController
  def new
      @event = set_event
      @pledge = @event.pledges.build
  end

  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.donor = Donor.find_or_create_by(user: current_user)
    @pledge.event = set_event
    if @pledge.save
        @pledge.event.update_funded_status_if_goal_reached
        redirect_to event_path(set_event)
    else
        render 'new'
    end
  end

  private

  def pledge_params
      params.require(:pledge).permit(:amount)
  end

  def set_event
     Event.find(params[:event_id])
  end

end
