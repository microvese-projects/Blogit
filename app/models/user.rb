class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  def recent_posts
    @recent_posts = self.posts.order(created_at: :desc).limit(3)
    @recent_posts
  end
end
