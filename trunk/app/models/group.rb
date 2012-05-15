# == Schema Information
# Schema version: 20110314031400
#
# Table name: groups
#
#  id   :integer(10)     primary key
#  name :string(64)      not null
#

class Group < ActiveRecord::Base
  has_many :bottles, :dependent => :destroy # If the group is destroyed then all bottles for the group are also destroyed
  
end
