class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.username} to Alpha Blog"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user = User.update(user_params) && @user.password?
      redirect_to articles_path
      flash[:notice] = "Updated your profile successfully"
    else
      render 'edit'
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
