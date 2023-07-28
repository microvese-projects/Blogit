class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    return unless current_user

    if liked?(@post, params[:user_id])
      flash.now[:notice] = 'You already liked this post.'
    else
      @like = Like.new
      @like.author_id = params[:user_id]
      @like.post_id = params[:post_id]

      if @like.save
        redirect_to user_post_path(params[:user_id], params[:post_id])
      else
        flash.now[:notice] = 'Could not like the post!'
      end
    end
  end

  private

  def liked?(post, id)
    Like.exists?(author_id: id, post_id: post.id)
  end
end
