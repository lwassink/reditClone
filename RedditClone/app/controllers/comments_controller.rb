class CommentsController < ApplicationController
  before_action :redirect_unless_logged_in

  before_action :redirect_unless_author, only: [:edit, :update, :destroy]

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = comment_params[:post_id]
    @comment.author = current_user
    @comment.parent_comment_id = comment_params[:parent_comment_id]

    if @comment.valid?
      @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment
      post = @comment.post
      @comment.destroy
      redirect_to post_url(post)
    else
      redirect_to :back
    end
  end

  private
  def redirect_unless_author
    comment = Comment.find(params[:id])
    redirect_to :back unless comment.author == current_user
  end

  def comment_params
    params.require(:comment).permit(:post_id, :content, :parent_comment_id)
  end
end
