class PostsController < ApplicationController
  before_action :redirect_unless_logged_in

  before_action :redirect_unless_author, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    # fail
    if @post.valid?
      @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      @post.destroy
    end
    redirect_to :back
  end

  private
  def redirect_unless_author
    post = Post.find(params[:id])
    redirect_to :back unless post.author == current_user
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
