# == Schema Information
# Schema version: 20110314031400
#
# Table name: suppliers
#
#  id           :integer(38)     not null, primary key
#  name         :string(255)
#  email        :string(255)
#  phone_number :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Supplier < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy # If the supplier is destroyed then all bottles from this supplier are also destroyed
  
  validates :name,  :presence     => true,
                    :length       => { :within => 2..40 }
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :allow_blank => true
                    
  def self.search(search, page_no)
    
    if search
      @suppliers = find(:all, :conditions => ['lower(name) LIKE ?', "#{search.downcase}%"], :order => "LOWER(name)").paginate(:page => page_no)
    else
      @suppliers = order("LOWER(name)").paginate(:page => page_no)
    end
  end

end
