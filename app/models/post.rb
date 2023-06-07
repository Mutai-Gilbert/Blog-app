class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :post_counter
  has_many :like
  has_many :comment

  def top_5_comment
    comment.order(created_at: :desc).limit(5)
  end

  after_save :increment_post_counter

  private

  def increment_post_counter
    author.increment!(:post_counter)
  end
end
