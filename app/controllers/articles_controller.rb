class ArticlesController<ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user , except: [:show, :index]
  before_action :require_current_user , only: [:edit, :update , :destroy]

  def show
  end

  def index
    @articles = Article.order(:created_at).page params[:page]
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article created successfully..."
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully..."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
    flash[:notice] = "Article deleted successfully..."
  end


  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_current_user
    if @article.user != current_user && !current_user.admin?
      redirect_to @article
      flash[:notice] = "You can't perform this action"
    end
  end

end
