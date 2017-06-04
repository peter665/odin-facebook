class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    f = current_user.sent_friend_requests
    unless f.collect { |u| u.receiving_user_id }.include?(params[:id_receiving].to_i)
      f.build(receiving_user_id: params[:id_receiving])
        if f[-1].save
          flash[:success] = 'Friend request sent'
          redirect_to authenticated_root_path
        else
          flash[:danger] = 'Error while sending friend request'
          redirect_to authenticated_root_path
        end
    else
      flash[:danger] = "You have already sent a friend request to this user!"
      redirect_to authenticated_root_path
    end
  end

  def destroy

  end

  def update
    current_user.received_friend_requests.find_by(sending_user_id: params[:update_id]).update(accepted: true)
    redirect_to user_path(current_user)
  end


end
