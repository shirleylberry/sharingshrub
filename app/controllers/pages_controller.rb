class PagesController < ApplicationController
  
  skip_before_action :require_login, only: [:home]
  
  def home
    @events = Event.all
  end

end