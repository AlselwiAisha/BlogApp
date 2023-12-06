class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts
    # @comments = @post.recent_comments
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    end
end
