class Message < ActiveRecord::Base
	belongs_to :user

	scope :msg_public, lambda { where(:msg_public => true) }
end
