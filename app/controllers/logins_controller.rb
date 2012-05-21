class LoginsController < ApplicationController
   skip_before_filter :authenticate
   attr_reader :title, :subheading
   
   def initialize
     super
     @title = "Login"
     @subheading = "Sign in Details"
   end

   def new
     @user = User.new
   end

   def destroy
      session[:person] = nil
      session[:username] = nil
      session[:role] = nil
      session[:last_authenticated_at] = nil
      session[:return_to] = nil
      flash[:heading] = "Security:"
      flash[:notice] = "Logged out"
      redirect_to login_path
   end
   
   def create
     @user = User.new(params[:user])
     if @user.valid?
       if @user.authenticated?
         # Sign the user in and redirect to the correct page.
         logger.debug "user: #{@user.to_yaml}"
         session[:person] = true 
         session[:username] = @user.name
         session[:role] = @user.role.nil? ? "" : @user.role.name
         session[:last_authenticated_at] = Time.now
         
         if session[:return_to]
            redirect_to(session[:return_to])
            session[:return_to] = nil
         else
            redirect_to root_path
         end
       else
         render :new
       end
     else
       render :new
     end
   end # create
end
