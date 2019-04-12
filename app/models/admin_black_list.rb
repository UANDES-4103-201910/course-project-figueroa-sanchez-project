class AdminBlackList < ApplicationRecord
  belongs_to :black_list
  belongs_to :user
end
