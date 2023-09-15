class CategoriesController < ApplicationController

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

  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  private

  def set_params
    params.require(:category).permit(:name)
  end

end
