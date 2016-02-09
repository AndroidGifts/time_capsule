class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :created_at, :delivery_date, :like_count

  has_one :user
  has_many :comments
end