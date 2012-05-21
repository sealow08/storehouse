module ApplicationCommon
  module Security
    def is_admin
      is_admin = session[:role].to_s.eql?("admin")

      if !is_admin
        flash[:heading] = "Security"
        flash[:notice] = "You must be an administrator user to access the Admin areas."
        redirect_to root_path 
      end
    end
  end
end
