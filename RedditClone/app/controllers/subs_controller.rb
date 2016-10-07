class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  before_action :redirect_unless_logged_in, except: [:index, :show]
  before_action :redirect_unless_author, only: [:edit, :update]

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.valid?
      @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def redirect_unless_author
    sub = Sub.find(params[:id])
    redirect_to sub_url(sub) unless sub.moderator == current_user
  end
end
