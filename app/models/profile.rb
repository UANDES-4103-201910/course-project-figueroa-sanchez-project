class Profile < ApplicationRecord
  belongs_to :user
  has_one :profile_location
  has_one :location, through: :profile_location
  has_one_attached :image
  validates :bio, length: { maximum: 500 }
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }

  def self.get_user_profile(id)
    user_profile = Profile.where(user_id: id)
    user_profile
  end


  def self.get_profile_by_name(keyword)
    profiles = Array.new
    all_profiles = Profile.all
    first_name_profile = all_profiles.where("first_name LIKE ?", "%#{keyword}%")
    last_name_profile = all_profiles.where("first_name LIKE ?", "%#{keyword}%")

    if first_name_profile
      first_name_profile.each do |profile|
        n_profile = Hash.new
        n_profile['id'] = profile.id
        n_profile['user_id'] = profile.user_id
        n_profile['name'] = profile.first_name + ' ' + profile.last_name
        n_profile['bio'] = profile.bio
        n_profile['country'] = profile.country
        n_profile['city'] = profile.city
        profiles << n_profile
      end
    end

    if last_name_profile
      last_name_profile.each do |profile|
        n_profile = Hash.new
        n_profile['id'] = profile.id
        n_profile['user_id'] = profile.user_id
        n_profile['name'] = profile.first_name + ' ' + profile.last_name
        n_profile['bio'] = profile.bio
        n_profile['country'] = profile.country
        n_profile['city'] = profile.city
        profiles << n_profile
      end
    end
    profiles = profiles & profiles
    profiles
  end

  def self.get_profile_by_location(keyword)
    profiles = Array.new
    all_profiles = Profile.all
    profiles_by_city = all_profiles.where("city LIKE ?", "%#{keyword}%")
    profiles_by_country = all_profiles.where("city LIKE ?", "%#{keyword}%")

    if profiles_by_city
      profiles_by_city.each do |profile|
        n_profile = Hash.new
        n_profile['id'] = profile.id
        n_profile['user_id'] = profile.user_id
        n_profile['name'] = profile.first_name + ' ' + profile.last_name
        n_profile['bio'] = profile.bio
        n_profile['country'] = profile.country
        n_profile['city'] = profile.city
        profiles << n_profile
      end
    end

    if profiles_by_country
      profiles_by_country.each do |profile|
        n_profile = Hash.new
        n_profile['id'] = profile.id
        n_profile['user_id'] = profile.user_id
        n_profile['name'] = profile.first_name + ' ' + profile.last_name
        n_profile['bio'] = profile.bio
        n_profile['country'] = profile.country
        n_profile['city'] = profile.city
        profiles << n_profile
      end
    end
    profiles = profiles & profiles
    profiles
  end
end
