class Api::CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      post = Post.find(params[:post_id])
      comments = post.comment
      render json: comments
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Post not found' }, status: :not_found
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  
    def create
      post = Post.find(params[:post_id])
      comment = post.comment.new(comment_params)
      comment.author = current_user
      if comment.save
        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Post not found' }, status: :not_found
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end