class Profile < ApplicationRecord
  belongs_to :user
  has_one :profile_location
  has_one :profile_photo
end
