class Validation < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validate :vote_type
  validates_uniqueness_of :post_id, :scope => [:user_id]

  def vote_type
    if vote != 1 && vote != -1
      errors.add(:vote, "Must be 1 or -1")
    end
  end
end
