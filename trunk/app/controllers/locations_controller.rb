class LocationsController < ApplicationController
  include ApplicationCommon::Security
  attr_reader :title, :subheading
  before_filter :is_admin

  def initialize
    super
    @title = "Location"
  end

  def index
    @title = "Locations"
    @subheading = "List of locations"

    @locations = Location.search(params[:search], params[:page])
    if @locations.empty?
      flash.now[:error] = "Zero locations found."
      flash.now[:heading] = "Search result:"
    else
      session[:back_btn_path] = request.fullpath
    end
  end

  def show
      @location = Location.find(params[:id])
      @subheading = @location.name
  end  

  def new
    @location = Location.new
    @subheading = "New location details"
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      flash[:heading] = "Location admin:"
      flash[:notice] = "Location created."
      redirect_to locations_path
    else
      @subheading = "New location details"
      render :new 
    end
  end

  def edit
    @location = Location.find(params[:id])
    @subheading = "Edit: #{@location.name}"
  end 

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:heading] = "Location admin:"
      flash[:notice] = "Location updated."
      redirect_to locations_path
    else
      @title = "Edit Location"
      render :edit
    end
  end

  def destroy
    Location.find(params[:id]).destroy
    flash[:heading] = "Location admin:"
    flash[:notice] = "Location successfully deleted."
    redirect_to locations_path
  end

end
