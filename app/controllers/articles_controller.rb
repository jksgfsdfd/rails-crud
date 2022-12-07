class ArticlesController < ApplicationController

    before_action :set_article, only: [:show,:edit,:update,:destroy]

    #to enable operations with articles before adding authentication functionality
    before_action :set_user, only: [:create,:update,:destroy]    
    
    def show
        #@article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(params.require(:article).permit(:title,:description))
        if @article.save
            flash[:notice] = "Article saved successfully"
            redirect_to article_path(@article)
        else
            render 'new'
        end
        # article = Article.new
        # article.title = entered_article["title"]
        # article.description = entered_article["description"]
        # article.save
    end

    def edit
        #@article = Article.find(params[:id])
    end

    def update
        #@article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "successfully edited the article"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy
        #@article = Article.find(params[:id])
        if @article.destroy
            flash[:notice] = "successfully deleted the article"
        end
        redirect_to articles_path()
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def set_user
        @article.user = User.first
    end

    def article_params
        params.require(:article).permit(:title,:description)
    end
end