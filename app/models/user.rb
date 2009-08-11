class User < ActiveRecord::Base
  has_many :votes, :through => :tallies
  has_many :tallies
  
  attr_accessor :password, :password_confirmation

  validates_uniqueness_of :login, :email
  validates_presence_of :password, :unless => Proc.new { |t| t.hashed_password }
  validates_presence_of :password_confirmation, :unless => Proc.new { |t| t.hashed_password }
  validates_presence_of :login, :email
  
  validates_confirmation_of :password

  def self.authenticate(login, pass)
    current_user = first(:conditions => { :login => login })
    return nil if current_user.nil?
    return current_user if User.encrypt(pass, current_user.salt) == current_user.hashed_password
    nil
  end  
  
  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt
    self.hashed_password = User.encrypt(@password, self.salt)
  end
  
  def admin?
    self.permission_level == -1
  end
  
  def guest?
    self.permission_level == 0
  end
  
  protected
  
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
  
  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
end
