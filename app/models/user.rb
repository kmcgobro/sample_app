require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
	
	validates :name,
				:presence => true,
				:length => {:maximum => 32}
	
	validates :email,
				:presence => true,
				:format => {:with => /^[a-z]+[\w\d\-.]+@[a-z\d]+\.[a-z]{3}/i},
				:uniqueness => {:case_sensitive => false}
				
	validates :password,
				:presence => true,
				:confirmation => true,
				:length => {:within => 6..40}
				
	before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    if user.nil?
      nil
    elsif user.has_password?(submitted_password)
      user
    else
      nil
    end
  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
