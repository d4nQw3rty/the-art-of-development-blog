class Post < ApplicationRecord
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_save :update_posts_counter

  def latest_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_posts_counter
    counter = Post.count('author_id')
    author.update(posts_counter: counter)
  end
end
