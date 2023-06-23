class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.includes(post: [:author, { comment: [:author] }]).find(params[:user_id])
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.post.new(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end 

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
