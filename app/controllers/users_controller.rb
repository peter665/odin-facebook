class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @friends = @user.friends

  end
  def index
    @users = User.where.not(["id = ?", current_user.id])
  end

  def timeline

  end

end
