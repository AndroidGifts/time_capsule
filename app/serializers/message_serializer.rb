class MessageSerializer < ActiveModel::Serializer
  attributes :id, :msg_public, :msg_to, :subject, :content, :like_count, :comment_count, :delivery_time, :created_at

  has_one :user
  has_many :comments
end