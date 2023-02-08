class ArticleController < ApplicationController
    
    before_action :authorize_request, except: [:home, :show ,:destroy]
    #---------- reference for inserting category in article --------- 
     # @articles = Article.all

        # @categories = Category.all

        # for category in @categories
        #     if @articles[0].categories.find_by(name: category.name) == nil
        #         @articles[0].categories << category
        #     end
        # end

    
        # render json: @articles[0]
    #---------------------------------------------------------------------
    def home
        render html: "Articles Home"
    end

    def show
       
        if params[:id]
            article = Article.find_by(id: params[:id])
            render :json => article, :include => [:user => {:except => :password_digest}, :categories => {:only => :name}]
        elsif params[:title]
            articles = Article.where("title LIKE ?", "%" + Article.sanitize_sql_like(params[:title]) + "%")
            render json: articles, :include => [:user => {:except => :password_digest}, :categories => {:only => :name}]
        elsif params[:category]
            # category = Category.where("name LIKE ?", "%" + Category.sanitize_sql_like(params[:category]) + "%")
            category = Category.find_by(name: params[:category])
            render json: category.articles, :include => [:user => {:except => :password_digest}, :categories => {:only => :name}]
        # ------- find by author email -----------------
        elsif params[:email]
            user = User.find_by_email(params[:email])
            render json: user.articles, :include => [:user => {:except => :password_digest}, :categories => {:only => :name}]
        
        elsif params[:author_name]
            user = User.find_by_name(params[:author_name])
            render json: user.articles, :include => [:user => {:except => :password_digest}, :categories => {:only => :name}]

        else
            articles = Article.all
            render json: articles, :include => [:user => {:except => :password_digest}, :categories => {:only => :name}]
        end

        
    end

    def create
        if @current_user == nil
            render json:{ errors: "User not authorized" }, status: :unauthorized
        else

            @article = @current_user.articles.create(title: params[:title], text: params[:text])

            for category_name in params[:categories]
                if Category.find_by(name: category_name) == nil
                    @category = Category.create(name: category_name)
                else 
                    @category = Category.find_by(name: category_name)
                end

                if @article.categories.find_by(name: category_name) == nil
                    @article.categories << @category 
                end
            end
            render :json => @article, :include => {:categories => {:only => :name}}
        end
    end

    def update
        
        article = Article.find_by(id: params[:id])
        
        if article.user_id != @current_user.id
            render json: {error: "Unauthorized"}, status: :unauthorized
        else
            if article.update(article_params) == nil
                render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            else
                render :json => article
            end
        end
        

    end

    def delete
        article = Article.find_by(id: params[:id])
        
        if article.user_id != @current_user.id
            render json: {error: "Unauthorized"}, status: :unauthorized
        else
            article.destroy
        end
    end
    def destroy
        for article in Article.all
            article.destroy
        end
    end


    private

    def article_params
        params.permit(
            :title, :text, :categories, :image_url
        )
    end


end
