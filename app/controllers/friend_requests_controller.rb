class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    unless current_user.friends.ids.include?(params[:id_receiving].to_i)
      f = current_user.sent_friend_requests.build(receiving_user_id: params[:id_receiving])
        if f.save
          flash[:success] = 'Friend request sent'
          redirect_to users_path
        else
          flash[:danger] = 'You have already sent a friend request to this user!'
          redirect_to users_path
        end
    else
      flash[:danger] = "You are already friends!"
      redirect_to users_path
    end
  end

  def destroy

  end

  def update
    current_user.received_friend_requests.find_by(sending_user_id: params[:update_id]).update(accepted: true)
    redirect_to user_path(current_user)
  end


end
