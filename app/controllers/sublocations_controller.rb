class SublocationsController < ApplicationController
  include ApplicationCommon::Security
  attr_reader :title, :subheading
  before_filter :is_admin

  def initialize
    super
    @title = "Sub-location"
  end

  def index
    @title = "Sub-locations"
    @subheading = "List of sub-locations"
    @sublocation = Sublocation.new(params[:sublocation]) # This is to set the location select box with the currently selected sublocation.location_id 
    @sublocations = Sublocation.search(params[:sublocation], params[:page])
    if @sublocations.empty?
      flash.now[:error] = "Zero sub-locations found."
      flash.now[:heading] = "Search result:"
    else
      session[:back_btn_path] = request.fullpath
    end
  end

  def show
      @sublocation = Sublocation.find(params[:id])
      @subheading = @sublocation.name
  end  

  def new
    @sublocation = Sublocation.new
    @subheading = "New sub-location details"
  end

  def create
    @sublocation = Sublocation.new(params[:sublocation])
    if @sublocation.save
      flash[:heading] = "Sub-location admin:"
      flash[:notice] = "Sub-location created."
      redirect_to sublocations_path
    else
      @subheading = "New sub-location details"
      render :new 
    end
  end

  def edit
    @sublocation = Sublocation.find(params[:id])
    @subheading = "Edit: #{@sublocation.name}"
  end 

  def update
    @sublocation = Sublocation.find(params[:id])
    if @sublocation.update_attributes(params[:sublocation])
      flash[:heading] = "Sub-location admin:"
      flash[:notice] = "Sub-location updated."
      redirect_to sublocations_path
    else
      @title = "Edit Sub-location"
      render :edit
    end
  end

  def destroy
    Sublocation.find(params[:id]).destroy
    flash[:heading] = "Sub-location admin:"
    flash[:notice] = "Sub-location successfully deleted."
    redirect_to sublocations_path
  end

end
