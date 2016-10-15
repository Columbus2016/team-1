class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    if @comment.save
      redirect_to @comment.shout
    else
      # TODO: fix this garbage TBH fam
      redirect_to @comment.shout, warning: "Comment couldn't be saved"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_edit_params)
      redirect_to @comment.shout
    else
      redirect_to @comment.shout, warning: "Can't edit that for some reason"
    end
  end

  protected

  def comment_params
    params.require(:comment)
      .permit(:body, :post_id)
      .merge(user_id: current_user.id)
  end

  def comment_edit_params
    params.require(:comment)
      .permit(:body)
  end

end
