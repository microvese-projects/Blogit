class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @new_user_post = Post.new
  end

  def create
    @post = Post.new(author: @current_user, title: values[:title], text: values[:text])

    if @post.save
      puts "called save"
      redirect_to user_post_path(@current_user, @post)
    else
      puts "called exit"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def values
    params.require(:post).permit(:title, :text)
  end
end
