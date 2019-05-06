class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.get_post_comments(id)
    post_comments = Comment.where(post_id: id)
  end
end
