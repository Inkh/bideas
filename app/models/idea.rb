class Idea < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates :content, presence: true, length: { minimum: 2}

  before_save do
    self.content.downcase!
  end
end
