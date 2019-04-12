class BlackList < ApplicationRecord
  belongs_to :user
  has_one :admin_black_list

end
