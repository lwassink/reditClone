class PostsController < ApplicationController
  before_action :redirect_unless_logged_in

  before_action :redirect_unless_author, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.valid?
      @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      sub = @post.sub
      @post.destroy
      redirect_to sub_url(sub)
    else
      redirect_to root_url
    end
  end

  private
  def redirect_unless_author
    post = Post.find(params[:id])
    redirect_to sub_url(post) unless post.author == current_user
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
