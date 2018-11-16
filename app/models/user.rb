class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :blogs, dependent: :destroy
  mount_uploader :profile_image, ImageUploader
  has_many :likes, dependent: :destroy
  has_many :like_blogs, through: :likes, source: :blog
  
  def like(blog)
    self.likes.find_or_create_by(blog_id: blog.id)
  end
  
  def unlike(blog)
    like = self.likes.find_by(blog_id: blog.id)
    like.destroy if like
  end

  def like?(blog)
    self.like_blogs.include?(blog)
  end
end