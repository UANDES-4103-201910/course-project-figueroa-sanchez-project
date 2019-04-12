class UserPassword < ApplicationRecord
  belongs_to :user
  validates :password, presence: true, :format => {
      with: /\A^([a-zA-Z0-9]{9,36})\z/i,
      message: "password must be only alphanumeric and between 9 and 36 characters"
  }
end
