class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  after_create :update_user_posts_counter

  private

  def update_user_posts_counter
    author.increment(:posts_counter)
  end
end
