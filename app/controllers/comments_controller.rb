class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @post.comment = @post
    authorize @comment
  end

  private

  def comment_params
    params.require(:post).permit(:title) #May not need .permit(:title) because only one argument
  end

end
