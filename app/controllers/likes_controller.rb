class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    liked_post = current_user.likes.build(likes_params)
    if liked_post.save
      flash[:success] = 'You liked this post'
      redirect_to posts_path
    else
      flash[:danger] = 'You already liked this post!'
      redirect_to posts_path
    end
  end


  private
    def likes_params
      params.require(:post).permit(:post_id)
    end
end
