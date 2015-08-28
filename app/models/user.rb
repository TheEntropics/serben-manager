class User < ActiveRecord::Base
  validates_presence_of :username, :password
  validates_uniqueness_of :username

  has_secure_password

  def self.get_user(username, password)
    User.find_by(username: username).try(:authenticate, password)
  end
end
