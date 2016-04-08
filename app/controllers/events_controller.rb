class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    binding.pry
  end
end
