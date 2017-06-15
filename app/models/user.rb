class User < ApplicationRecord
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :sending_user_id
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :receiving_user_id

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy, foreign_key: :commenter_id

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100", mini: "50x50#", micro: "30x30#"}

  # has_many :friends, -> { where(friend_requests: { accepted: true}) }, through: :friend_requests,
  #           foreign_key: :receiving_user_id, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 3.megabytes

  validates :name, :surname, presence: true
  validates_attachment :avatar,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }



  def friends
   friends =  self.sent_friend_requests.where("accepted = ?", true).collect { |f| f.receiving_user_id }
   friends += self.received_friend_requests.where("accepted = ?", true).collect { |f| f.sending_user_id }
   User.where(id: friends)
  end

  def new_friend_req
    self.received_friend_requests.where(accepted:false).count
  end

  def liked? post
    self.liked_posts.include?(post)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name.split(' ').first   # assuming the user model has a name
      user.surname = auth.info.name.split(' ').last
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
