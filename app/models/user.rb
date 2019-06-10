class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :admin_black_lists
  has_one :black_list
  has_many :comments
  has_many :posts
  has_one :profile
  accepts_nested_attributes_for :profile
  has_many :reports
  has_many :user_role
  has_many :roles, through: :user_role
  has_many :validations
  has_many :searches
  has_many :follow_posts
  has_many :admin_locations
  has_many :locations, through: :admin_locations

  def self.users_by_roles
    user_roles = UserRole.all
    all_users = User.all
    normal_users = Array.new
    administrators = Array.new
    superadmin = User.where(id: user_roles.where(role_id: 3))
    user_roles.where(role_id: 1).each do |user_role|
      normal_users << all_users.where(id: user_role.user_id)
    end
    user_roles.where(role_id: 2).each do |user_role|
      administrators << all_users.where(id: user_role.user_id)
    end
    return normal_users, administrators, superadmin
  end


  def is_suspended?
    black_list = BlackList.find_by_user_id(id)
    if black_list
      if black_list.created_at > Time.now-1.week
        true
      else
        false
      end
    end
  end

  def suspension_time
    if self.is_suspended?
      (BlackList.find_by_user_id(id).created_at + 1.week).to_date
    end
  end

  def innapropiate_posts_count
    posts = self.posts
    count = 0
    posts.each do |post|
      if post.is_inappropriate?
        count+=1
      end
    end
    count
  end

  def get_actual_photo
    user_profile_id = Profile.where(user_id: id).id
    @actual_profile_photo = ProfilePhoto.where(profile_id: user_profile_id)
                                .order(created_at: :desc)
                                .limit(1).photo_link

  end

  def is_admin?
    admin_role = UserRole.where(user_id: id, role_id: 2)
    if admin_role.length > 0
      true
    else
      false
    end
  end

  def is_super_admin?
    super_admin_role = UserRole.where(user_id: id, role_id: 3)
    if super_admin_role.length > 0
      true
    else
      false
    end
  end

  def black_list
    if self.is_in_black_list?
      self.is_active = false
      return false
    end
    black_list = BlackList.new(user_id: id)
    user_posts = self.posts
    user_posts.each do |post|
      if post.is_inappropriate?
        if not post.is_in_dumpster?
          Dumpster.create(post_id: post.id)
        end
      end
    end
    if black_list.save
      true
    else
      false
    end
  end

  def is_in_black_list?
    BlackList.where(user_id:id).length > 0
  end

  def get_role
    role = UserRole.where(user_id: id)
    roles = Array.new
    role.each do |r|
      roles << r.role_id
    end
    roles.max
  end

  # def get_geofences
  #   geofences_raw = AdminLocation.where(user_id: id)
  #   geofences = Array.new
  #   geofences_raw.each do |geo|
  #     geofences << geo.location
  #   end
  #   geofences
  # end

  def destroy_geofences
    AdminLocation.where(user_id:id).destroy_all
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data['name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end

# User.users_by_roles