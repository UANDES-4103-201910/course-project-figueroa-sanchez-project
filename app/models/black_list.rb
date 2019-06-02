class BlackList < ApplicationRecord
  belongs_to :user
  has_one :admin_black_list
  validates_uniqueness_of :user_id

  def get_posts
    black_list = BlackList.all
    black_list_posts = Array.new
    black_list.each do |item|
      black_list_posts << Post.find(item.post_id)
    end
    black_list_posts
  end
end
