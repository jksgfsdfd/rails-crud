class ArticlesController < ApplicationController

    before_action :set_article, only: [:show,:edit,:update,:destroy]
    
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
        @article = Article.new(article_params)
        @article.user = current_user
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
        if !logged_in? || !(@article.user == current_user)
            flash[:alert] = "You can only edit your articles"
            redirect_to root_path
        end
    end

    def update
        #@article = Article.find(params[:id])
        if !logged_in? || !(@article.user == current_user)
            flash[:alert] = "You can only edit your articles"
            redirect_to root_path
        end

        if @article.update(article_params)
            flash[:notice] = "successfully edited the article"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy
        #@article = Article.find(params[:id])
        if !logged_in? || !(@article.user == current_user)
            flash[:alert] = "You can only delete your articles"
            redirect_to root_path
        end

        if @article.destroy
            flash[:notice] = "successfully deleted the article"
            redirect_to articles_path()
        else
            flash.now[:alert] = "Couldn't delete the article"
            render "show",status: 422
        end
        
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:description)
    end
end