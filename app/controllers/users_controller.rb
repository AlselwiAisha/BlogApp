class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.recent_posts
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
