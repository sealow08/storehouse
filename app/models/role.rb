# == Schema Information
# Schema version: 20110314031400
#
# Table name: roles
#
#  id         :integer(38)     not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  has_many :users, :dependent => :destroy # If the role is destroyed then all users with this role are also destroyed
  
end
