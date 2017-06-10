class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def show
    @user = User.find(params[:id])
    @friends = @user.friends
  end

  def index
    @users = User.where.not(["id = ?", current_user.id]).paginate(page: params[:page], per_page: 20)
  end



end
