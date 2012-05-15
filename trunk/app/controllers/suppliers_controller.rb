class SuppliersController < ApplicationController
  include ApplicationCommon::Security
  attr_reader :title, :subheading
  before_filter :is_admin
  
  def initialize
    super
    @title = "Supplier"
  end

  def index
    @title = "Suppliers"
    @subheading = "List of suppliers"
    
    @suppliers = Supplier.search(params[:search], params[:page])
    if @suppliers.empty?
      flash.now[:error] = "Zero suppliers found."
      flash.now[:heading] = "Search result:"
    else
      session[:back_btn_path] = request.fullpath
    end
  end
  
  def show
      @supplier = Supplier.find(params[:id])
      @subheading = @supplier.name
  end  
  
  def new
    @supplier = Supplier.new
    @subheading = "New supplier details"
  end
  
  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:heading] = "Supplier admin:"
      flash[:notice] = "Supplier created."
      redirect_to suppliers_path
    else
      @subheading = "New supplier details"
      render :new 
    end
  end
  
  def edit
    @supplier = Supplier.find(params[:id])
    @subheading = "Edit: #{@supplier.name}"
  end 
  
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:heading] = "Supplier admin:"
      flash[:notice] = "Supplier updated."
      redirect_to suppliers_path
    else
      @title = "Edit Supplier"
      render :edit
    end
  end
  
  def destroy
    Supplier.find(params[:id]).destroy
    flash[:heading] = "Supplier admin:"
    flash[:notice] = "Supplier successfully deleted."
    redirect_to suppliers_path
  end

end
