class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @user = User.find(params[:user_id])
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user

    if @comment.save
      redirect_to "/users/#{@user.id}/posts/#{params[:post_id]}", notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment # Authorize the action
    @post = @comment.post
    @post.decrement!(:comments_counter)
    @comment.destroy
    redirect_to user_post_path(params[:user_id], @comment.post_id), notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
