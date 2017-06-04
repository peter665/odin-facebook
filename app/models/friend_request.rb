class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: :sending_user_id
  belongs_to :receiver, class_name: "User", foreign_key: :receiving_user_id


end
