class Profile < ApplicationRecord
  belongs_to :user
  has_one :profile_location
  has_one :profile_photo
  validates :bio, length: { maximum: 500 }
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
end
