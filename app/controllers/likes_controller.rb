class LikesController < ApplicationController
  def create
    current_post = Post.find_by(id: params[:post_id])
    like = Like.new(user: current_user, post: current_post)
    current_post.save

    if like.save
      redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
    else
      render :new
    end
  end
end
