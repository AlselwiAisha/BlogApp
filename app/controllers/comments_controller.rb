class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(post_params)
    @comment.user = current_user
    @post = Post.find_by(id: params[:post_id])
    @comment.post = @post
    if @comment.save
      @post.save
      redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
