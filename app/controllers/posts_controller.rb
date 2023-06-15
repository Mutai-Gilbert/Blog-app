class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])
  end
  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
  end
end
