class Post < ApplicationRecord
  has_many :attachments
  has_one :dumpster
  belongs_to :user
  has_many :reports
  has_many :comments
  has_many :validations
  has_many :shared_posts
end
