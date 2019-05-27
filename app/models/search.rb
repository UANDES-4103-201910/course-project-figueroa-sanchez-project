class Search < ApplicationRecord
  class << self
    def create!(attrs = { })
      new(attrs).save!
    end

    def last
      # retrieve the attrs from storage
      new(attrs)
    end
  end

  def initialize(attrs = {})
    @attrs = attrs
  end

  def keywords
    @attrs[:keywords]
  end

  def save!
    # store the attrs somewhere
    # maybe serialized in the session, or in mongo or memcached
  end


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
