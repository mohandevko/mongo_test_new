class VenuesController < ApplicationController
  before_filter :is_login
  def index
    @venues = current_user.venues.where(:role => "user")
  end
  
  def new
    @venue = Venue.new
  end
  
  def create
    @venue = current_user.venues.new(venue_params)
    if @venue.save
      flash[:notice] = "Venue uploaded successfully!"
      redirect_to venues_path
    else
      flash[:error] = "Venue upload failed!"
      render :action => :new
    end
  end
  
  private
  def venue_params
    params.require(:venue).permit!
  end
end
