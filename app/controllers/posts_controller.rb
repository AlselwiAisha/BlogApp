class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end
  def destroy
    current_post = Post.find_by(id: params[:post_id])
    authorize! :destroy, current_post
    current_post.comments.each(&:destroy)
    current_post.likes.each(&:destroy)
    current_post.destroy
    user_post_counter = User.find_by(id: params[:id])
    user_post_counter.posts_counter -= 1
    user_post_counter.save
    redirect_to posts_path(id: params[:id])
  end
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
