class Post < ApplicationRecord
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_save :update_posts_counter
  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def latest_comments
    comments.includes(:author).limit(5).order(created_at: :desc)
  end

  def update_posts_counter
    counter = Post.where(author_id:).count
    author.update(posts_counter: counter)
  end
end
