class CommentsController < ApplicationController
  def create
    
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    authorize @comment

    if @comment.save
      redirect_to [@post.topic, @post], notice: "Comment saved successfully."
    else
      redirect_to [@post.topic, @post], notice: "Comment failed to save."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error deleting the comment.  Try again."
      redirect_to [@post.topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user) #May not need .permit(:body) because only one argument
  end

end
