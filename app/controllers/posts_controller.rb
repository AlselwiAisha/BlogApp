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

  def new
    @user = User.find(params[:user_id])
    @add_new_post = @user.posts.build
  end

  def create
    current_user = User.find(params[:user_id])
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:add_new_post).permit(:title, :text)
  end
end
