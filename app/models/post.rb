class Post < ApplicationRecord
  has_many :attachments
  has_one :dumpster
  belongs_to :user
  has_many :reports
  has_many :comments
  has_many :validations
  has_many :shared_posts
  validates :title, presence: true, length: { maximum: 50 }

  def self.get_posts_ordered_by_votes
    posts_with_validations = Validation.group(:post_id).count
    @posts_ordered_by_votes = Array.new
    posts_with_validations.keys.sort_by { |key| posts_with_validations[key] }.each do
    |key|
      @posts_ordered_by_votes << Post.find(key)
    end
    @posts_ordered_by_votes.reverse
    @posts_ordered_by_votes
  end

end

#Post.get_posts_ordered_by_votes