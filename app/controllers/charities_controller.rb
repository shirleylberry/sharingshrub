class CharitiesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show]
  before_action :authenticate_admin!, only: [:new, :create]

  def new
    @charity = Charity.new
  end

  def create
  end

  def show
    set_charity
  end

  private

  def set_charity
    @charity = Charity.find(params[:id])
  end

end
