class AdminLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
end
