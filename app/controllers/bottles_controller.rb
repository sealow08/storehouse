class BottlesController < ApplicationController
    include ActionView::Helpers::TextHelper
    attr_reader :title, :subheading

    def initialize
      super
      @title = "Bottle"
    end

    def index
      @title = "Bottles"
      @subheading = "List of bottles"

      @bottles = Bottle.search(params[:bottle], params[:page], params[:substance])
      if @bottles.empty?
        flash.now[:error] = "Zero results found."
        flash.now[:heading] = "Search result:"
      else
        session[:back_btn_path] = request.fullpath
      end
    end

    def show
        @bottle = Bottle.includes(:supplier, :substance, :unit, :sublocation, :group).find(params[:id])
        @subheading = "Bottle: #{@bottle.id}, #{@bottle.substance.name}"
    end  

    def new
      @bottle = Bottle.new 
      @subheading = "New bottle details"
      @sublocations = Array.new # An empty collection because not location has be chosen yet
    end

    def create
      @bottle = Bottle.new(params[:bottle])
      @bottle.assign_substance(params[:substance])
      
      if @bottle.valid?
        @bottle.save_batch
        flash[:heading] = "Bottle management:"
        flash[:notice] = "#{pluralize( @bottle.quantity.to_i, 'Bottle' )} created."
        redirect_to new_bottle_path
      else
        @subheading = "New bottle details"
        @sublocations = Sublocation.find_all_by_location_id(@bottle.location_id, :order => :name)
        render :new 
      end
    end

    def edit
      @bottle = Bottle.find(params[:id])
      @subheading = "Edit: bottle #{@bottle.id}"
      @sublocations = Sublocation.find_all_by_location_id(@bottle.sublocation.location, :order => :name)
    end 

    def update
      @bottle = Bottle.find(params[:id])
      @bottle.assign_substance(params[:substance])
      
      if @bottle.update_attributes(params[:bottle])
        flash[:heading] = "Bottle management:"
        flash[:notice] = "Bottle updated."
        redirect_to new_bottle_path
      else
        @title = "Edit Bottle"
        @sublocations = Sublocation.find_all_by_location_id(@bottle.location_id, :order => :name)
        render :edit
      end
    end

    def destroy
      Bottle.find(params[:id]).destroy
      flash[:heading] = "Bottle management:"
      flash[:notice] = "Bottle successfully deleted."
      redirect_to new_bottle_path
    end
    
    def search
      @bottle = Bottle.new
      @bottle.date_received = nil
      @subheading = "Search for bottle"
    end
    
    def sublocation_select
      @sublocations = Sublocation.find_all_by_location_id(params[:location_id], :order => :name)
      render :layout => false
    end
    
    def retire
      Bottle.find(params[:id]).retire
      flash[:heading] = "Bottle management:"
      flash[:notice] = "Bottle successfully retired."
      redirect_to new_bottle_path
    end

end
