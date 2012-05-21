class SubstancesController < ApplicationController
  include ApplicationCommon::Security
  attr_reader :title, :subheading
  before_filter :is_admin

  def initialize
    super
    @title = "Substance"
  end

  def index
    @title = "Substances"
    @subheading = "List of substances"

    #@substances = Substance.search(params[:sublocation], params[:page])
    @substances = Substance.search(params[:search], params[:page])
    #@bottles = Bottle.search(params[:bottle], params[:page])
    
    if @substances.empty?
      flash.now[:error] = "Zero substances found."
      flash.now[:heading] = "Search result:"
    else
      session[:back_btn_path] = request.fullpath  
    end
  end

  def show
      @substance = Substance.find(params[:id])
      @subheading = @substance.name
  end  

  def new
    @substance = Substance.new
    @subheading = "New substance details"
  end

  def create
    @substance = Substance.new(params[:substance])
    if @substance.save
      flash[:heading] = "Substance admin:"
      flash[:notice] = "Substance created."
      redirect_to substances_path
    else
      @subheading = "New substance details"
      render :new 
    end
  end

  def edit
    @substance = Substance.find(params[:id])
    @subheading = "Edit: #{@substance.name}"
  end 

  def update
    @substance = Substance.find(params[:id])
    if @substance.update_attributes(params[:substance])
      flash[:heading] = "Substance admin:"
      flash[:notice] = "Substance updated."
      redirect_to substances_path
    else
      @title = "Edit Substance"
      render :edit
    end
  end

  def destroy
    Substance.destroy(params[:id])
    flash[:heading] = "Substance admin:"
    flash[:notice] = "Substance successfully deleted."
    redirect_to substances_path
  end

end
