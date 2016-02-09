class User < ActiveRecord::Base
	attr_accessor :full_name

	has_many :messages, dependent: :destroy
	has_many :comments, dependent: :destroy
end