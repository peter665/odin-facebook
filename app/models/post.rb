class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :likes, dependent: :destroy

  default_scope -> { order(created_at: :desc)}

  has_attached_file :picture, styles: { medium: "300x300", thumb: "100x100", mini: "50x50!"}

  validates_attachment :picture,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  validates :content, presence: true, length: { minimum: 3, maximum: 255}
end
