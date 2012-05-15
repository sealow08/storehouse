# == Schema Information
# Schema version: 20110314031400
#
# Table name: users
#
#  id         :integer(38)     not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  role_id    :integer(38)
#

class User < ActiveRecord::Base
  attr_accessor :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  belongs_to :role

  validates :name, :presence => true,
                :length   => { :maximum => 50 }
  validates :password, :presence => true,
                :length   => { :maximum => 50 } 
#   validates :email, :format   => { :with => email_regex },
#                  :uniqueness => { :case_sensitive => false }
                  
  def self.authenticate (login, password)
    user = nil
    
    if !login.blank? && !password.blank?
      login = "#{login}@bmsi.a-star.edu.sg"
      if auth_against_source(login, password) 
        # Try to get the user from the db, this is to check their role
        user = User.find_by_name(login.split("@")[0].downcase)
        if user.nil?
          # if they are not in the db but have been authenticated above then they must be a standard user ie not admin.  The default value for user.admin? is false. Split removes the email domain from the login.
          user = User.new(:name => login.split("@")[0].downcase)
        end
      end
    end
    
    user
  end
  
  def authenticated?
    user = User.authenticate(self.name, self.password)
    if user.nil? 
      self.errors.add(:login, "Invalid user/password combination")
      false
    else
      self.role = user.role
      true
    end    
  end

  private 
  
  def self.auth_against_source (login, password)
    ldap = Net::LDAP.new
    ldap.host = 'bmsiad01.bmsi.a-star.edu.sg'
    ldap.base ='ou=ETC Users,ou=ETC,dc=bmsi,dc=a-star,dc=edu,dc=sg'
    ldap.port = 389
    ldap.auth login, password

    # bind returns true if user details are authenticated by the server otherwise false if they aren't
    logger.debug "ldap.bind: #{ldap.bind}"
    ldap.bind
  end
end
