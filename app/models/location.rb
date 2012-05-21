# == Schema Information
# Schema version: 20110314031400
#
# Table name: locations
#
#  id         :integer(38)     not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
#  has_many :bottles, :dependent => :destroy # If the location is destroyed then all bottles with this location are also destroyed
  has_many :sublocations, :dependent => :destroy # If the location is destroyed then all sublocations and bottles at sublocations are also destroyed
    
  validates :name,  :presence     => true,
                    :length       => { :within => 3..40 }
                    
  def self.search(search, page_no)
    if search
      @locations = find(:all, :conditions => ['lower(name) LIKE ?', "%#{search.downcase}%"], :order => "LOWER(name)").paginate(:page => page_no)
    else
      @locations = order("LOWER(name)").paginate(:page => page_no)
    end
  end

end
