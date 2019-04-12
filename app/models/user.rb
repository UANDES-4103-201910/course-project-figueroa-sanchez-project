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
  has_one :user_role
  has_many :user_passwords
  has_many :validations
  validates :email, presence: true, email: true
end
