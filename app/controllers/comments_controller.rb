class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = post.comment.new(author: current_user, **comment_params)
    if @comment.save
      redirect_to user_post_path(post.author, post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
