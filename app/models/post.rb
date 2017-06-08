class Post < ApplicationRecord
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  default_scope -> { order(created_at: :desc)}

  validates :content, presence: true, length: { minimum: 3, maximum: 255}
end
