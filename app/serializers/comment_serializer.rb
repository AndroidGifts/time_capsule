class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :message_id, :content
end