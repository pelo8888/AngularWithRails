class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote]
  protect_from_forgery with: :exception

  respond_to :json

  def comment_params 
    params.require(:comment).permit(:body) 
  end

  def create
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with post, comment
  end

  def upvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.increment!(:upvotes)

    respond_with post, comment
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
