# == Schema Information
# Schema version: 20110314031400
#
# Table name: units
#
#  id         :integer(38)     not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Unit < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy # If the unit is destroyed then all bottles with this unit are also destroyed
  
end
