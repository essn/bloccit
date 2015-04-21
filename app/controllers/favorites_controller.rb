class FavoritesController < ApplicationController
  def create
    puts "in favorites controller"
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    authorize favorite
    if favorite.save!
      flash[:notice] = "Post has been favorited."
      redirect_to [@post.topic, @post]
    else
      flash[:notice] = "There was an error favoriting the post.  Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    authorize favorite
    if favorite.destroy
      flash[:notice] = "Post has been unfavorited."
      redirect_to [@post.topic, @post]
    else
      flash[:notice] = "There was an error unfavoring the post.  Please try again."
      redirect_to [@post.topic, @post]
    end
  end
end
