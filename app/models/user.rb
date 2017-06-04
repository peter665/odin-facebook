class User < ApplicationRecord
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :sending_user_id
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :receiving_user_id

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy, foreign_key: :commenter_id

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # has_many :friends, -> { where(friend_requests: { accepted: true}) }, through: :friend_requests,
  #           foreign_key: :receiving_user_id, source: :user
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, :surname, presence: true



  def friends
   friends =  self.sent_friend_requests.where("accepted = ?", true).collect { |f| f.receiving_user_id }
   friends += self.received_friend_requests.where("accepted = ?", true).collect { |f| f.sending_user_id }
   User.where(id: friends)
  end

  def new_friend_req
    self.received_friend_requests.where(accepted:false).count
  end


end
