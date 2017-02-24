class User < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea
  has_secure_password
  validates :name, :alias, presence: true, length: { minimum: 2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX}
  validates :password, length: { minimum: 8}, on: :create

  before_save do
    self.name.downcase!
    self.alias.downcase!
    self.email.downcase!
  end
end
