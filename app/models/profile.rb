class Profile < ApplicationRecord
  belongs_to :user
  has_one :profile_location
  has_one_attached :image
  validates :bio, length: { maximum: 500 }
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }

  def self.get_user_profile(id)
    user_profile = Profile.where(user_id: id)
    user_profile
  end
end
