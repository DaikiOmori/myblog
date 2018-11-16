class Blog < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :content, presence: true
  mount_uploader :blog_image, ImageUploader
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
