class PostLocation < ApplicationRecord
  belongs_to :post
  belongs_to :location
end
