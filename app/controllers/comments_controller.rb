class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    commentable = find_commentable
    comment = commentable.comments.build(comment_params)
    if comment.save
      flash[:success] = 'Comment posted!'
      redirect_back fallback_location: authenticated_root_path
    else
      flash[:danger] = comment.errors.full_messages.to_sentence
      redirect_back fallback_location: authenticated_root_path
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:body, :commenter_id)
    end

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

end
