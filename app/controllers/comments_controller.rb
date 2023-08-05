class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author_id = params[:user_id]
    @comment.post = @post

    if @comment.save
      respond_to do |format|
        format.json { render json: @comment, status: :created }
        format.html { redirect_to user_post_path(params[:user_id], params[:post_id]) }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Could not add comment' }, status: :unprocessable_entity }
        format.html { render :new, alert: 'Error: Could not add comment.' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    Post.find(params[:post_id]).reduce_counter

    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
