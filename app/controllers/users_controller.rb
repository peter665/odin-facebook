class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @friends = @user.friends

  end
  def index
    @users = User.all
  end

  def timeline

  end

end
