class PagesController < ApplicationController
  include ApplicationCommon::Security
  attr_reader :title, :subheading
  before_filter :is_admin, :only => :admin
  
  def admin
    @title = "Admin"
    @subheading = "Dashboard"
  end

end
