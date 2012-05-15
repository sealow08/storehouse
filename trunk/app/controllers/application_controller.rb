class ApplicationController < ActionController::Base
   include GeneralHelper::Convertions
   protect_from_forgery
   before_filter :authenticate

   protected

   #this routine is called on every single page load so it makes sense to update :last_authenticated here and throw back to login screen if the last page access was too long ago

  def authenticate
#    logger.debug "request.fullpath: #{request.fullpath}"
    unless session[:person]
       session[:return_to] = request.fullpath
       redirect_to login_path
       return false
    end
    manage_session()
  end

   def manage_session
      time_out_minutes = 20

#      logger.debug "\n\nLast authenticated: #{session[:last_authenticated_at]}, Now:#{Time.now}, #{to_whole_minutes(Time.now - session[:last_authenticated_at])}mins ago.\n\n"
      
      if to_whole_minutes(Time.now - session[:last_authenticated_at]) >= time_out_minutes
         redirect_to logout_path
      else
         session[:last_authenticated_at] = Time.now
      end
   end # manage_session

end # ApplicationController

