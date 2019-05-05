class Validation < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validate :validate_only_one_vote
  def validate_only_one_vote
    errors.add(:user_id, "A user can not validate a post twice") if
        Validation.where(post_id: post_id, user_id: user_id).length > 0
  end
end
