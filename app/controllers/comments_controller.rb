class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comment.new(comment_params)
    @comment.user_id = current_user.id
    authorize @comment
  end

  private

  def comment_params
    params.require(:post).permit(:title) #May not need .permit(:title) because only one argument
  end

end
