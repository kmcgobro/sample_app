class User < ActiveRecord::Base
	attr_accessible :name, :email
	
	validates :name,
				:presence => true,
				:length => {:maximum => 32}
	
	validates :email,
				:presence => true,
				:format => {:with => /^[a-z]+[\w\d\-.]+@[a-z\d]+\.[a-z]{3}/i},
				:uniqueness => {:case_sensitive => false}
end
