class Search < ApplicationRecord
  belongs_to :user

  def profiles
    @profile ||= find_profiles
  end

  private

  def find_profiles
    profiles = Profile.order(:first_name)
    profiles = profiles.where("location and username") if keywords.present?
    profiles = profiles.where("first_name like ?", "%#{username}%") if username.present?
    profiles = profiles.where("last_name like ?", "%#{username}%") if username.present?
    profiles = profiles.where("location like ?", "%#{location}%") if location.present?
    profiles
  end


end
