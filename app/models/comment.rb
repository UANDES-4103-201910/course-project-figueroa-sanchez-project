class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.get_post_comments(id)
    post_comments = Comment.where(post_id: id)
  end

  def get_user_photo
    user = User.find(user_id)
    user_photo = user.get_actual_photo
  end
end
