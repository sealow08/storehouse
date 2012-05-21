# == Schema Information
# Schema version: 20110315081343
#
# Table name: substances
#
#  id           :integer(38)     not null, primary key
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  sort_keyword :string(255)
#

class Substance < ActiveRecord::Base
  # Callbacks
  before_save :create_sort_keyword

  has_many :bottles, :dependent => :destroy # If the substance is destroyed then all bottles with this substance are also destroyed

  validates :name,  :presence     => true

  def self.search(search, page_no)
    logger.debug "Search: #{search}"
    
    if search
      @substances = find(:all, :conditions => ['lower(name) LIKE ?', "%#{search.downcase}%"], :order => "LOWER(sort_keyword)").paginate(:page => page_no)
    else
      @substances = order("LOWER(sort_keyword)").paginate(:page => page_no)
    end
  end
  
  private
    def create_sort_keyword
      # Set a default sort keyword if the user didn't provide one
      self.sort_keyword = self.name.scan(/[A-Z]+[a-z]+/)[0] if self.sort_keyword.blank?
    end
  
end
