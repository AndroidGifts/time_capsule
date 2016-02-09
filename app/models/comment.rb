class Comment < ActiveRecord::Base
	attr_accessor :user_name
	attr_accessor :user_avatar

	belongs_to :user
	belongs_to :message
end
