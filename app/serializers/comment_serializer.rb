class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_name, :user_avatar

  def user_name
  	"#{object.user.first_name}" + ' ' + "#{object.user.last_name}"
  end

  def user_avatar
  	"#{object.user.user_avatar}"
  end
end
