class CategoriesController < ApplicationController

  before_action :require_admin_user, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      flash[:notice] = "New category added"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(set_params)
      flash[:notice] = "Article updated successfully..."
      redirect_to @category
    else
      render 'edit'
    end
  end

  def show
    @articles = @category.articles
  end

  def index
    @categories = Category.order(:name).page params[:page]
  end

  def destroy
    @category.destroy
    redirect_to categories_path
    flash[:notice] = "Catgory deleted successfully..."
  end

  private

  def set_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin_user
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins allowed"
      redirect_to categories_path
    end
  end

end
