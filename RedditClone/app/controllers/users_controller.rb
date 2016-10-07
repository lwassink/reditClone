class UsersController < ApplicationController

  before_action :redirect_unless_logged_in, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def new
  end

  def show

    @user = User.find_by_session_token(session[:session_token])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
