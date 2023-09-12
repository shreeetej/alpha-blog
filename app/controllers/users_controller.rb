class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user , only: [:edit , :update]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.order(:title).page params[:page]
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
    redirect_to articles_path if logged_in?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username} to Alpha Blog"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Updated your profile successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Deleted account successfully..."
    redirect_to root_path
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_current_user
    if @user != current_user && !current_user.admin?
      redirect_to @user
      flash[:notice] = "You don't have access to this account"
    end
  end

end
