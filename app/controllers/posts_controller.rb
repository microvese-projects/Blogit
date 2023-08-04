class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = Post.all.includes(:author).where(users: { id: params[:user_id] })

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end
  end

  def new
    @new_user_post = Post.new
  end

  def create
    return unless current_user

    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new, alert: 'Verify the information!'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy
    User.find(params[:user_id]).reduce_counter
    redirect_to user_path(current_user), notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
