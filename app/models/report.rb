class Report < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :report_category
end
