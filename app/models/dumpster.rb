class Dumpster < ApplicationRecord
  belongs_to :post

  def get_dumped_posts
    dumpster = Dumpster.all
    dumped_posts = Array.new
    dumpster.each do |item|
      dumped_posts << Post.find(item.post_id)
    end
    dumped_posts
  end
end
