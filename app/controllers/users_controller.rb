class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    puts params[:id]
    @user = User.find(params[:id])
  end
end
