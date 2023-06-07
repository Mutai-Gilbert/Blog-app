class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :likes_counter

  after_save :increment_like_counter

  private

  def increment_like_counter
    post.increment!(:likes_counter)
  end
end
