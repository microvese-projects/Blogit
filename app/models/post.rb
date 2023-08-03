class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  before_validation :initialize_counters

  after_create :update_user_posts_counter

  validates :title, presence: true, length: { in: 3..250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def reduce_counter
    self.decrement!(:comments_counter)
  end

  private

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def initialize_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
