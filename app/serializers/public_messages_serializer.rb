class PublicMessagesSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :created_at, :user_name

  def user_name
  	"#{object.user.first_name}" + ' ' + "#{object.user.last_name}"
  end
end
