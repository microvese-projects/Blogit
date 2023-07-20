class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  after_create :update_comments_counter

  private

  def update_comments_counter
    post.update_column(:comments_counter, post.comments_counter.to_i + 1)
  end
end
