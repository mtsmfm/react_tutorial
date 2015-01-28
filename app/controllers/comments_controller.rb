class CommentsController < ApplicationController
  def index
    @comments = Comment.all

    render json: @comments
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: Comment.all
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author, :text)
  end
end
