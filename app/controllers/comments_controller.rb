class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    return unless current_user

    @post = Post.find(params[:post_id])
    @comment = Comment.new(text: values[:comment], author_id: params[:user_id], post_id: params[:post_id])

    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      render :new, alert: 'Error: Could not add comment.'
    end
  end

  private

  def values
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
