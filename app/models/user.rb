class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  has_many :admin_black_lists
  has_many :admin_locations
  has_one :black_list
  has_many :comments
  has_many :posts
  has_one :profile
  has_many :reports
  has_many :user_role
  has_many :user_passwords
  has_many :validations
  has_many :roles, through: :user_role
  validates :mail, presence: true, uniqueness: true


  def self.users_by_roles
    user_roles = UserRole.all
    all_users = User.all
    normal_users = Array.new
    administrators = Array.new
    superadmin = User.where(id:user_roles.where(role_id: 3))
    user_roles.where(role_id:1).each do |user_role|
      normal_users << all_users.where(id:user_role.user_id)
    end
    user_roles.where(role_id:2).each do |user_role|
      administrators << all_users.where(id:user_role.user_id)
    end
    return normal_users, administrators, superadmin
  end

  def get_actual_photo
    user_profile_id = Profile.where(user_id: id).id
    actual_profile_photo = ProfilePhoto.where(profile_id: user_profile_id)
                                       .order(created_at: :desc)
                                       .limit(1).photo_link

  end

  def get_role
    role = UserRole.where(user_id:id).first.role_id
  end

  def self.get_admins_mails
    admins_ids = UserRole.where(role_id: 2)
    admins = Hash.new
    admins_ids.each do |role|
      admins[role.id] = User.find(role.id).mail
    end
    admins
  end

  def get_geofences
    geofences_raw = AdminLocation.where(user_id:id)
    geofences = Array.new
    geofences_raw.each do |geo|
      geofences << geo.location
    end
    geofences
  end


end

# User.users_by_roles