class Search < ApplicationRecord
  belongs_to :user

  def profiles
    @profiles ||= find_profiles
  end

  private

  def find_profiles
    profiles = Profile.all
    if location
      profile_locations = ProfileLocation.where("location LIKE ? ", "#{keywords}").profile if keywords.present?
      profiles = []
      profile_locations.each do |locations|
        profiles.append(Profile.find_by_if(locations.profile))
      end
    else
      profiles = Profile.where("first_name LIKE ? ", "#{keywords}") if keywords.present?
    end
    profiles
  end
end
