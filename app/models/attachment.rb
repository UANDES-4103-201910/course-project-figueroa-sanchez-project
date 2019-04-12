class Attachment < ApplicationRecord
  belongs_to   :post
  has_one :category
end
