class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :post_counter
  has_many :like
  has_many :comment
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def increment_post_counter
    author.increment!(:post_counter)
  end

  def top_5_comment
    comment.order(created_at: :desc).limit(5)
  end
end
