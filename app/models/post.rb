class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  after_create :update_user_posts_counter

  def recent_comments
    @post_comments = self.comments.order(created_at: :desc).limit(5)
    @post_comments
  end

  private

  def update_user_posts_counter
    author.increment(:posts_counter)
  end
end
