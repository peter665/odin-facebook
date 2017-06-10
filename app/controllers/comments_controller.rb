class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Post.find(params[:post_id]).comments.build(comment_params)
    if comment.save
      flash[:success] = 'Comment posted!'
      redirect_to post_path(params[:post_id])
    else
      flash[:danger] = comment.errors.full_messages.to_sentence
      redirect_to post_path(params[:post_id])
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:body, :commenter_id)
    end

end
