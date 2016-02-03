class Message < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	scope :msg_public, lambda { where(:msg_public => true) }
end