# == Schema Information
# Schema version: 20110603071421
#
# Table name: bottles
#
#  id             :integer(38)     not null, primary key
#  supplier_id    :integer(38)
#  substance_id   :integer(38)
#  size           :integer(38)
#  unit_id        :integer(38)
#  po_number      :string(255)
#  group_id       :integer(38)
#  date_received  :date
#  created_at     :datetime
#  updated_at     :datetime
#  cas_number     :string(255)
#  sublocation_id :integer(38)
#  product_cat_no :integer(38)
#  retired_at     :datetime
#  flammable      :boolean(1)
#  hazardous      :boolean(1)
#  barcode        :string(255)
#

class Bottle < ActiveRecord::Base
  attr_accessor :quantity
  attr_accessor :location_id
  attr_accessor :sublocation_new
  @loc_id # See the overriden attr_accessor methods for location_id for the purpose of this object variable
  @retired # Internal variable mostly used for search
  
  # Callbacks
  after_initialize :default_values
  before_save :create_any_new_sublocation
  
  # Association is belongs_to if object references an already existing object.  Assoc'n is has_a if referenced object is created at the same time, ie: account has_a account_history
  belongs_to :supplier
  belongs_to :substance
  belongs_to :unit
#  belongs_to :location # remove later as a sublocation links to a location
  belongs_to :sublocation
  belongs_to :group
  
  validates_presence_of :cas_number
  validates_presence_of :supplier_id
  validates_presence_of :substance_id
  validates_numericality_of :size, :greater_than => 0
  validates_presence_of :unit_id, :message => "of size not selected"
  # Only validate quantity if the bottle is new, ie has no id, as quantity is only used to create new bottles
  validates_numericality_of :quantity, :greater_than => 0, :integer_only => true, :if => "id.nil?"
  validates_presence_of :location_id
  # A sublocation must be chosen of the name of a new location supplied
  validates_presence_of :sublocation_id, :if => "sublocation_new.blank?", :message => "must be chosen from the list or a new sub-location for this location entered" 
#  validates_presence_of :sublocation_new, :if => "sublocation_id.nil?"
  validates_presence_of :po_number
  validates_presence_of :group_id

  def self.search(search, page_no, substance_name)
    search = clean_hash(search)
    
    if !search.empty? || !substance_name.empty?
      search_clause = ""
#      values_array = Array.new
      values_hash = Hash.new

      # Handle 'retired'
      if search.has_key?(:retired)
        search_clause = search[:retired] == "1" ? "retired_at is not null and " : "retired_at is null and "
        search.delete(:retired)
      end
      
      if !substance_name.empty?
        substance = Substance.find_by_name(substance_name)
        search[:substance_id] = substance.id if !substance.nil?
        
      end
      
      search.each { |key, value|
#        search_clause << "#{key} = ? and "
        search_clause << "#{key} = :#{key} and "
#        values_array << value
        values_hash[key.to_sym] = value
      }
      
      search_clause = search_clause.chomp(" and ")
      
      logger.debug "search_clause: #{search_clause}"  
      logger.debug "values_hash: #{values_hash.to_s}"  
      
      @bottles = includes(:supplier, :substance, :group).where(search_clause, values_hash).order("substances.name ASC, suppliers.name ASC, groups.name ASC").paginate(:page => page_no)
    else
      @bottles = includes(:supplier, :substance, :group).order("substances.name ASC, suppliers.name ASC, groups.name ASC").paginate(:page => page_no)
    end
  end
  
  def save_batch
    if self.valid?
      self.save
      (self.quantity.to_i - 1).times {
        if !self.clone.save
          return false
        end
      }
      return true
    end
    return false
  end
  
  def location_id # Override the default attr_accessor getter method 
    return self.sublocation.nil? ? @loc_id : self.sublocation.location_id
  end
  
  def location_id=(loc_id) # Override the default attr_accessor setter method as an intermediate location_id store is needed to prevent self referencing endless stack loop in getter method
      @loc_id = loc_id #set the contents of loc_id to loc_id  
  end
  
  def retired? 
    # If the date of the retirement is blank then retired = false , unless retired was set to true in the case of search.  The main use of 'retired' is as a search form variable, not as a true bottle attribute
    if !self.retired_at.blank?
      true
    else
      @retired.blank? ? false : @retired
    end
  end
  
  def retired=(status)
    @retired = status
  end
  
  def retire()
    self.retired_at = DateTime.now
    self.save
  end
  
  def assign_substance(substance_name)
    if !substance_name.empty?
      self.substance = Substance.find_by_name(substance_name)
      if self.substance.nil?
        self.substance = Substance.create(:name => substance_name)
      end
    else
      self.substance = nil
    end
  end
  
  private
    def default_values
      if new_record?
        self.date_received ||= Date.current
        self.retired = false
      end
    end
    
    def create_any_new_sublocation
      if !self.sublocation_new.blank? #&& self.sublocation.nil?
        self.sublocation = Sublocation.create(:name => self.sublocation_new, :location_id => self.location_id)
        self.sublocation_new = nil
      end
    end
    
    def self.clean_hash(search)
      # Remove blank search terms
      search.delete_if { |key, value| value.blank? }
      
      if search.length == 1 && search.has_key?(:retired)
        # Then there must only be one clause, retired. If it is blank (unchecked) then might as well remove it as well because it means the whole search form was blank.
        search.delete(:retired) if search[:retired] == "0"
      end
      
      return search
    end
end
