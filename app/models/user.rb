require 'bcrypt'
require 'faker'

class User < ActiveRecord::Base
  include BCrypt
  
  has_many :sources
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :password, presence: true

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by(email: email)
    if @user
      return @user if @user.password == password
    end
    nil
  end

end
