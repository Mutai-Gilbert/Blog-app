class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :post, foreign_key: 'author_id'
  has_many :like, foreign_key: 'author_id'
  has_many :comment, foreign_key: 'author_id'
  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def top_3_posts
    post.order(created_at: :desc).limit(3)
  end
end
