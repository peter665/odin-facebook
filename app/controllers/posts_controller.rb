class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(author: current_user.friends.to_a << current_user)
    @new_post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = "You made a new Post!"
        redirect_to posts_path
      else
        flash[:danger] = @post.errors.full_messages.to_sentence
        redirect_to posts_path
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy

  end

  private
    def post_params
      params.require(:post).permit(:content, :picture)
    end

end
