class Location < ApplicationRecord
  has_many :profile_locations
  has_many :admin_locations
  has_many :post_locations
  has_many :users, through: :admin_locations
  has_many :profiles, through: :profile_locations
  has_many :posts, through: :post_locations
end
