class PostsController < ApplicationController
  def index
    @posts = current_user.posts.includes(:comments)
  end

  def show
    @post = current_user.posts.includes(:comments).find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
