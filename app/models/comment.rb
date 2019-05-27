class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.get_post_comments(id)
    post_comments = Comment.where(post_id: id)
    comments = Array.new
    post_comments.each do |comm|
      user_comment = Hash.new
      user_comment['user_profile_id'] = Profile.find(comm.user_id).id
      user_comment["user_first_name"] = Profile.find(comm.user_id).first_name
      user_comment["user_last_name"] = Profile.find(comm.user_id).last_name
      user_comment["text"] = comm.comment
      user_comment["date"] = comm.created_at.to_date
      comments << user_comment
    end
    comments
  end

  def get_user_photo
    user = User.find(user_id)
    user_photo = user.get_actual_photo
  end
end
