class Report < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :report_category
  validates_uniqueness_of :post_id, :scope => [:user_id]

  def self.get_reported_posts
    reports = Report.group(:post_id)
    reported_posts = Array.new
    reports.each do |item|
      reported_posts << Post.find(item.post_id)
    end
    reported_posts
  end





end
