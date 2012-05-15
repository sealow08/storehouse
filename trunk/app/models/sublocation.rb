# == Schema Information
# Schema version: 20110314031400
#
# Table name: sublocations
#
#  id          :integer(38)     not null, primary key
#  name        :string(255)
#  location_id :integer(38)
#  created_at  :datetime
#  updated_at  :datetime
#

class Sublocation < ActiveRecord::Base
  belongs_to :location
  has_many :bottles, :dependent => :destroy # If the sublocation is destroyed then all bottles with this location are also destroyed
  
  validates             :name,  :presence     => true,
                                :length       => { :within => 3..40 }
  validates_presence_of :location_id
                    
  def self.search(search, page_no)
    if !search.nil?
      search = nil if search[:location_id].blank? 
    end
    
    if search 
      @sublocations = includes(:location).where(search).order("LOWER(locations.name) ASC, LOWER(sublocations.name) ASC").paginate(:page => page_no)
    else
      @sublocations = includes(:location).order("LOWER(locations.name) ASC, LOWER(sublocations.name) ASC").paginate(:page => page_no)
    end
  end
  
end
