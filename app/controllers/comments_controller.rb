class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @add_new_comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @comment = Comment.new(post_params)
    @comment.user = @user
    @post = Post.find_by(id: params[:post_id])
    @comment.post = @post
    if @comment.save
      @post.save
      redirect_to "/users/#{@user.id}/posts/#{params[:post_id]}"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:add_new_comment).permit(:text)
  end
end
