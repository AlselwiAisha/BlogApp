class LikesController < ApplicationController
  def create
    current_user = User.find(params[:user_id])
    current_post = Post.find_by(id: params[:post_id])
    like = Like.new(user:current_user, post: current_post)
    current_post.save
    like.save
    return unless like.save

    redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
  end
end
